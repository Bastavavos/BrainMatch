import 'dart:io';
import 'package:brain_match/data/models/request/question_request.dart';
import 'package:brain_match/data/models/response/question_response.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../core/error/failure.dart';

final fakeApiProvider  = Provider<FakeApi>((ref) => FakeApi());

class FakeApi {
  static const String url = 'https://opentdb.com/api.php';

  Future<List<QuestionResponse>> getQuestions(QuestionRequest request) async {
    // call ws
    try {
      final response = await Dio().get(url, queryParameters: request.toMap());

      // get response
      if (response.statusCode == 200) {
        final data = Map<String, dynamic>.from(response.data);
        final results = List<Map<String, dynamic>>.from(data['results']);
        if (results.isNotEmpty) {
          return results.map((e) => QuestionResponse.fromMap(e)).toList();
        }
      }
      return [];
    } on DioException catch(err) {
      throw Failure(message: err.response?.statusMessage ?? 'Api call failed');
    } on SocketException {
      throw Failure(message: 'Check your connection');
    }
  }
}