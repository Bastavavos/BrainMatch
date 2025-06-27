import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart'; // Ajoute ce package pour des icônes modernes

class SelectionModePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5FD),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/himmel.png',
              height: 30,
            ),
            const SizedBox(width: 10),
            const Text(
              'BrainMatch',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
        toolbarHeight: 60,
      ),
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Choisis ton mode de jeu",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade700,
              ),
            ),
            const SizedBox(height: 30),
            _buildModeCard(
              context,
              title: "Solo",
              icon: LucideIcons.user,
              gradient: [Colors.purple.shade400, Colors.deepPurple.shade600],
              routeName: 'Solo',
            ),
            const SizedBox(height: 20),
            _buildModeCard(
              context,
              title: "Versus",
              icon: LucideIcons.users,
              gradient: [Colors.red.shade400, Colors.deepOrange.shade600],
              routeName: 'Versus',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModeCard(
      BuildContext context, {
        required String title,
        required IconData icon,
        required List<Color> gradient,
        required String routeName,
      }) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/confirm',
          arguments: routeName,
        );
      },
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: gradient.last.withOpacity(0.4),
              blurRadius: 10,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 20),
            Icon(icon, color: Colors.white, size: 36),
            const SizedBox(width: 20),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}