import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../provider/user_provider.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final baseUrl = dotenv.env['API_KEY'];

      // Étape 1 : enregistrement
      final registerResponse = await http.post(
        Uri.parse("$baseUrl/user/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "username": _usernameController.text.trim(),
          "email": _emailController.text.trim(),
          "password": _passwordController.text.trim(),
        }),
      );

      if (registerResponse.statusCode == 201) {
        // Étape 2 : login auto
        final loginResponse = await http.post(
          Uri.parse("$baseUrl/user/login"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "identifier": _emailController.text.trim(), // ou username, selon ton backend
            "password": _passwordController.text.trim(),
          }),
        );

        final loginData = jsonDecode(loginResponse.body);

        if (loginResponse.statusCode == 200) {
          // Tu dois avoir accès à ref pour modifier userProvider
          if (!mounted) return;
          final user = {
            'userId': loginData['userId'],
            'username': loginData['username'],
            'email': loginData['email'],
            'token': loginData['token'],
          };
          ref.read(userProvider.notifier).state = user;
          Navigator.pushReplacementNamed(context, '/main');
        } else {
          setState(() {
            _errorMessage = loginData['message'] ?? 'Échec de la connexion après inscription.';
          });
        }
      } else {
        final data = jsonDecode(registerResponse.body);
        setState(() {
          _errorMessage = data['message'] ?? 'Échec de l’inscription.';
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
            height: screenHeight * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo et Formulaire
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
                            controller: _usernameController,
                            decoration: _buildInputDecoration('Nom :'),
                            validator: (value) => value == null || value.isEmpty
                                ? 'Veuillez entrer un nom'
                                : null,
                          ),
                          const SizedBox(height: 16),

                          TextFormField(
                            controller: _emailController,
                            decoration: _buildInputDecoration('Email :'),
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

                // Bouton
                Column(
                  children: [
                    _buildRoundedSmallButton(
                      label: _isLoading ? 'Chargement...' : 'Valider',
                      icon: Icons.group_add,
                      onPressed: _isLoading ? null : _register,
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
        borderSide: const BorderSide(color: Colors.deepPurple),
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
