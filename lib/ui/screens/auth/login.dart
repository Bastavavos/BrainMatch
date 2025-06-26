import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../provider/user_provider.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final baseUrl = dotenv.env['API_KEY'];
      final response = await http.post(
        Uri.parse("$baseUrl/user/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "identifier": _identifierController.text.trim(),
          "password": _passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final user = {
          'userId': data['userId'], // ← pour cohérence avec /user/{id}
          'username': data['username'],
          'email': data['email'],
          'token': data['token'],
        };
        if (kDebugMode) {
          print("$user");
        }
        ref.read(userProvider.notifier).state = user;
        Navigator.pushReplacementNamed(context, '/main');
      } else {
        setState(() {
          _errorMessage = data["message"] ?? "Erreur de connexion.";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Erreur de réseau : $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/himmel.png',
                      height: 150,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),

              // Formulaire
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Email
                    TextFormField(
                      controller: _identifierController,
                      decoration: _buildInputDecoration('Identifier :'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Veuillez entrer un email'
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // Password
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: _buildInputDecoration('Mot de passe :'),
                      validator: (value) => value == null || value.isEmpty
                          ? 'Veuillez entrer un mot de passe'
                          : null,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),

              const SizedBox(height: 16),

              // Boutons
              Column(
                children: [
                  _buildButton(
                    context,
                    label: _isLoading ? 'Connexion...' : 'Connexion',
                    icon: Icons.power_settings_new,
                    onPressed: _isLoading ? null : _login,
                  ),
                  const SizedBox(height: 16),
                  _buildButton(
                    context,
                    label: 'Inscription',
                    icon: Icons.group_add,
                    onPressed: _isLoading
                        ? null
                        : () {
                      Navigator.pushNamed(context, '/register');
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.deepPurple),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required String label,
        required IconData icon,
        required VoidCallback? onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple.shade100,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
        ),
        icon: Icon(icon),
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }
}
