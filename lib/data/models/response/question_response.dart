import 'package:brain_match/domain/entities/question.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class QuestionResponse extends Equatable {
  final String category;
  final String difficulty;
  final String question;
  final String correctAnswer;
  final List<String> incorrectAnswers;

  const QuestionResponse({
    required this.category,
    required this.difficulty,
    required this.question,
    required this.correctAnswer,
    required this.incorrectAnswers,
});

  @override
  List<Object> get props => [
    category,
    difficulty,
    question,
    correctAnswer,
    incorrectAnswers,
  ];

  Question toEntity() {
    return Question(
      category: category,
      difficulty: difficulty,
      question: question,
      correctAnswer: correctAnswer,
      answers: incorrectAnswers..add(correctAnswer)..shuffle()
      // answers: [...incorrectAnswers, correctAnswer]..shuffle(),

    );
  }

  factory QuestionResponse.fromMap(Map<String, dynamic> map) {
    return QuestionResponse(
        category: map['category'] ?? '',
        difficulty: map['difficulty'] ?? '',
        question: map['question'] ?? '',
        correctAnswer: map['correctAnswer'] ?? '',
      incorrectAnswers: List<String>.from(map['incorrectAnswers'] ?? []),
    );
  }
}