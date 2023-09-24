import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuestionsNotifier extends StateNotifier<List<dynamic>> {
  QuestionsNotifier() : super([]);

  void setQuestions(List<dynamic> questions) {
    state = questions;
  }
}

final questionsProvider =
    StateNotifierProvider<QuestionsNotifier, List<dynamic>>(
        (ref) => QuestionsNotifier());
