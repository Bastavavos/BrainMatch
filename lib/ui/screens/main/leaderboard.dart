import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import '../../../models/user.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<User> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLeaderboard();
  }

  Future<void> fetchLeaderboard() async {
    final String baseUrl = dotenv.env['API_KEY']!;
    final response = await http.get(Uri.parse('$baseUrl/user'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<User> loadedUsers = data.map((e) => User.fromJson(e)).toList();

      // Trier par score décroissant
      loadedUsers.sort((a, b) => b.score.compareTo(a.score));

      setState(() {
        users = loadedUsers;
        isLoading = false;
      });
    } else {
      throw Exception('Erreur lors de la récupération des utilisateurs');
    }
  }

  Color _getRankColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFFFFD700); // Or
      case 1:
        return const Color(0xFFC0C0C0); // Argent
      case 2:
        return const Color(0xFFCD7F32); // Bronze
      default:
        return Colors.white;
    }
  }

  void _sendFriendRequest(String userId, String username) {
    // add api call add friends

    // await http.post(Uri.parse('$baseUrl/api/friends/add'), body: {'friendId': userId});

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Demande envoyée à $username")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("🏆 Classement")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final rankColor = _getRankColor(index);

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: rankColor.withOpacity(index < 3 ? 0.2 : 1),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: user.picture != null
                        ? CachedNetworkImageProvider(user.picture!)
                        : null,
                    child: user.picture == null
                        ? const Icon(Icons.person, size: 30)
                        : null,
                  ),
                  if (index < 3)
                    Positioned(
                      bottom: -2,
                      child: Text(
                        "#${index + 1}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: rankColor,
                        ),
                      ),
                    ),
                ],
              ),
              title: Text(
                user.username,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: Text('Score : ${user.score}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index >= 3)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        "#${index + 1}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  IconButton(
                    icon: const Icon(Icons.person_add),
                    onPressed: () => _sendFriendRequest(user.id, user.username),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
