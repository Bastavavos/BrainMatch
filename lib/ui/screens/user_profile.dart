import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//Example API call
class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String _responseBody = 'Chargement...'; // ← Variable pour stocker la réponse

  @override
  void initState() {
    super.initState();
    _fetchApi();
  }

  Future<void> _fetchApi() async {
    try {
      final response = await http.get(Uri.parse("http://192.168.1.66:3000/api/user/all"));
      setState(() {
        _responseBody = response.body;
      });
    } catch (e) {
      setState(() {
        _responseBody = 'Erreur: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Réponse de l'API")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(_responseBody),
      ),
    );
  }
}
