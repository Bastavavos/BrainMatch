import 'package:brain_match/ui/screens/login.dart';
import 'package:brain_match/ui/screens/main_layout.dart';
import 'package:brain_match/ui/screens/register.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/', // start here
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/main': (context) => MainLayout(),
      },
    );
  }
}
