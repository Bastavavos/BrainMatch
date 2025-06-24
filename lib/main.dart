import 'dart:convert';

import 'package:brain_match/screens/register.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'screens/login.dart';
import 'screens/main_layout.dart';
import 'screens/register.dart';

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
        '/register': (context) => RegisterPage(),
        '/main': (context) => MainLayout(), // Layout avec la NavBar
      },
    );
  }
}
