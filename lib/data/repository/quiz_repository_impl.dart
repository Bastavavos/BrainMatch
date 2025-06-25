import 'package:brain_match/data/api/fake_api.dart';
import 'package:brain_match/data/models/request/question_request.dart';
import 'package:brain_match/domain/repository/quiz_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../domain/entities/question.dart';

final quizRepositoryProvider = 
    Provider<QuizRepository>((ref) => QuizRepositoryImpl(ref.read(fakeApiProvider)));

class QuizRepositoryImpl extends QuizRepository {
  final FakeApi _fakeApi;

  QuizRepositoryImpl(this._fakeApi);

  @override
  Future<List<Question>> getQuestions({required int numQuestions, required int categoryId}) {
    return _fakeApi
        .getQuestions(QuestionRequest(type: 'multiple', amount: numQuestions, category: categoryId))
        .then((value) => value.map((e) => e.toEntity()).toList());
  }
}