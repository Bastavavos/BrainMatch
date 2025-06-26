import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/himmel.png',
              height: 30,
            ),
            SizedBox(width: 10),
            Text('BrainMatch'),
          ],
        ),
        centerTitle: true,
        toolbarHeight: 60,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCard(context, 'Solo', Colors.white60, 'Solo'),
            SizedBox(height: 20),
            _buildCard(context, 'Versus', Colors.white60, 'Versus'),
            SizedBox(height: 20),
            _buildCard(context, 'Rules', Colors.white60, '/rules'),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, Color color, String routeName) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/confirm',
          arguments: title, // On passe "Solo", "Versus", etc.
        );
      },
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4,
        child: Container(
          width: 300,
          height: 80,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
