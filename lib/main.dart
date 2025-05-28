import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/main_layout.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // On commence ici
      routes: {
        '/': (context) => LoginPage(),     // Page de connexion par défaut
        '/main': (context) => MainLayout(), // Layout avec la NavBar
      },
    );
  }
}
