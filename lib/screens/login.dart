import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

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
                    // Username/email
                    TextFormField(
                      decoration: _buildInputDecoration('Username / email :'),
                    ),
                    const SizedBox(height: 16),
                    // Password
                    TextFormField(
                      obscureText: true,
                      decoration: _buildInputDecoration('Password :'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Boutons
              Column(
                children: [
                  _buildButton(
                    context,
                    label: 'Connexion',
                    icon: Icons.power_settings_new,
                    onPressed: () {
                      // Simulation de connexion réussie
                      Navigator.pushReplacementNamed(context, '/main');
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildButton(
                    context,
                    label: 'Inscription',
                    icon: Icons.group_add,
                    onPressed: () {
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
        required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple.shade100,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
        ),
        icon: Icon(icon),
        label: Text(label),
        onPressed: onPressed,
      ),
    );
  }
}
