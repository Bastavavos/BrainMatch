import 'package:flutter/material.dart';

class QuizQuestionPage extends StatefulWidget {
  @override
  _QuizQuestionPageState createState() => _QuizQuestionPageState();
}

class _QuizQuestionPageState extends State<QuizQuestionPage> {
  final String questionText = "Qui est phil le fière ?";
  final List<String> answers = [
    "Dounia",
    "Strappazon",
    "Ronald",
    "McDonald",
  ];
  String? selectedAnswer;
  String correctAnswer = "Strappazon";

  void _selectAnswer(String answer) {
    if (selectedAnswer == null) {
      setState(() {
        selectedAnswer = answer;
      });
    }
  }

  Color _getColor(String answer) {
    if (selectedAnswer == null) return Colors.white;
    if (answer == correctAnswer) return Colors.green.shade100;
    if (answer == selectedAnswer) return Colors.red.shade100;
    return Colors.white;
  }

  IconData? _getIcon(String answer) {
    if (selectedAnswer == null) return null;
    if (answer == correctAnswer) return Icons.check_circle;
    if (answer == selectedAnswer) return Icons.cancel;
    return null;
  }

  Color _getIconColor(String answer) {
    if (answer == correctAnswer) return Colors.green;
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf4f6f8),
      appBar: AppBar(
        title: const Text('Question 1'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questionText,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            ...answers.map((answer) {
              return GestureDetector(
                onTap: () => _selectAnswer(answer),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: _getColor(answer),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          answer,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ),
                      if (_getIcon(answer) != null)
                        Icon(
                          _getIcon(answer),
                          color: _getIconColor(answer),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
            const Spacer(),
            if (selectedAnswer != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO: Logique suivante (next question)
                  },
                  child: const Text("Suivant"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey[800],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

