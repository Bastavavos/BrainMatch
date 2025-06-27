import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../../provider/user_provider.dart';

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
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SizedBox(
            height: screenHeight * 0.95, // occuper presque tout l'écran
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo
                Column(
                  children: [
                    const SizedBox(height: 32),
                    Image.asset(
                      'assets/images/himmel.png',
                      height: 150,
                    ),
                    const SizedBox(height: 24),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _identifierController,
                            decoration: _buildInputDecoration('Identifier :'),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Veuillez entrer un email'
                                : null,
                          ),
                          const SizedBox(height: 16),
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
                    const SizedBox(height: 16),
                    if (_errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                ),

                // Boutons
                Column(
                  children: [
                    _buildRoundedSmallButton(
                      label: _isLoading ? 'Connexion...' : 'Connexion',
                      icon: Icons.power_settings_new,
                      onPressed: _isLoading ? null : _login,
                    ),
                    const SizedBox(height: 16),
                    _buildRoundedSmallButton(
                      label: 'Inscription',
                      icon: Icons.group_add,
                      onPressed: _isLoading
                          ? null
                          : () {
                        Navigator.pushNamed(context, '/register');
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ],
            ),
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
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildRoundedSmallButton({
    required String label,
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Center(
      child: SizedBox(
        width: 200,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple.shade100,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            elevation: 3,
          ),
          icon: Icon(icon),
          label: Text(label),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
