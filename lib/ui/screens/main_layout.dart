import 'package:brain_match/ui/screens/quiz_page.dart';
import 'package:flutter/material.dart';
import '../widgets/nav_bar.dart';
import 'main/leaderboard.dart';
import 'main/selection_mode.dart';
import 'main/user_profile.dart';

class MainLayout extends StatefulWidget {
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    LeaderboardScreen(),
    SelectionModePage(),
    UserProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: NavBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
