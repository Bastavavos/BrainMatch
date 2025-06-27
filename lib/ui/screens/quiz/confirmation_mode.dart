import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart'; // Pour des icônes modernes

class ConfirmationMode extends StatelessWidget {
  final String selectedMode;
  const ConfirmationMode({super.key, required this.selectedMode});

  @override
  Widget build(BuildContext context) {
    final bool isSolo = selectedMode == 'Solo';

    final Color primaryColor = isSolo ? Colors.deepPurple : Colors.redAccent;
    final IconData icon = isSolo ? LucideIcons.user : LucideIcons.users;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F5FD),
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        title: const Text(
          'Confirmation',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 70, color: primaryColor),
            const SizedBox(height: 30),
            Text(
              'Tu as choisi le mode',
              style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              selectedMode,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                if (isSolo) {
                  Navigator.pushReplacementNamed(context, '/solo');
                } else {
                  Navigator.pushReplacementNamed(context, '/versus');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 6,
              ),
              child: const Text(
                'Commencer',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Annuler',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
