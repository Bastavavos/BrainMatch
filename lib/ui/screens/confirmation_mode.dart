import 'package:flutter/material.dart';

class ConfirmationMode extends StatelessWidget {
  final String selectedMode;

  const ConfirmationMode({required this.selectedMode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmation'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mode sélectionné : $selectedMode',
              style: TextStyle(fontSize: 22),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (selectedMode == 'Solo') {
                  Navigator.pushReplacementNamed(context, '/solo');
                } else if (selectedMode == 'Versus') {
                  Navigator.pushReplacementNamed(context, '/versus');
                }
              },
              child: const Text('Commencer'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
          ],
        ),
      ),
    );
  }
}
