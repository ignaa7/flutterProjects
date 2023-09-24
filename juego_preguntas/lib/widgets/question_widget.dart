import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:juego_preguntas/providers/players_names_provider.dart';

class QuestionWidget extends ConsumerStatefulWidget {
  final Map<String, dynamic> question;
  final Function getNextQuestion;
  final String currentPlayer;

  const QuestionWidget({
    super.key,
    required this.question,
    required this.getNextQuestion,
    required this.currentPlayer,
  });

  @override
  ConsumerState<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends ConsumerState<QuestionWidget> {
  late List<dynamic> answers;
  late String currentPlayer;
  bool? answer1;
  bool? answer2;
  bool? answer3;
  bool? answer4;
  bool isAnswered = false;
  // late Timer timer;

  @override
  void initState() {
    super.initState();
    answers = widget.question['respuestas'];
    answers.shuffle();
    currentPlayer = widget.currentPlayer;
  }

  @override
  void didUpdateWidget(covariant QuestionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    answers = widget.question['respuestas'];
    answers.shuffle();
    currentPlayer = widget.currentPlayer;
    answer1 = null;
    answer2 = null;
    answer3 = null;
    answer4 = null;
    isAnswered = false;

    // if (timer.isActive) {
    //   timer.cancel();
    // }
  }

  bool _checkAnswer(String answer) {
    bool isCorrect = false;
    if (answer == widget.question['respuesta_correcta']) {
      isCorrect = true;
    } else {
      if (answers[0] == widget.question['respuesta_correcta']) {
        answer1 = true;
      } else if (answers[1] == widget.question['respuesta_correcta']) {
        answer2 = true;
      } else if (answers[2] == widget.question['respuesta_correcta']) {
        answer3 = true;
      } else if (answers[3] == widget.question['respuesta_correcta']) {
        answer4 = true;
      }
    }

    if (isCorrect) {
      ref.read(playersNamesProvider.notifier).addPoint(currentPlayer);
    }
    isAnswered = true;

    return isCorrect;
  }

  // void _nextQuestion() {
  //   Duration duration = const Duration(seconds: 2);
  //   int cont = 0;
  //   timer = Timer.periodic(duration, (timer) {
  //     if (cont == 3) {
  //       widget.getNextQuestion();
  //     } else {
  //       cont++;
  //     }
  //   });
  // }

  @override
  void dispose() {
    // timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (isAnswered) _nextQuestion();

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text(
              widget.question['pregunta'],
              style: Theme.of(context).textTheme.titleSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: answer1 == null
                    ? null
                    : answer1!
                        ? Colors.green
                        : Colors.red,
              ),
              onPressed: () {
                if (!isAnswered) {
                  setState(() {
                    answer1 = _checkAnswer(answers[0]);
                  });
                }
              },
              child: Text(
                answers[0],
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: answer2 == null
                    ? null
                    : answer2!
                        ? Colors.green
                        : Colors.red,
              ),
              onPressed: () {
                if (!isAnswered) {
                  setState(() {
                    answer2 = _checkAnswer(answers[1]);
                  });
                }
              },
              child: Text(
                answers[1],
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: answer3 == null
                    ? null
                    : answer3!
                        ? Colors.green
                        : Colors.red,
              ),
              onPressed: () {
                if (!isAnswered) {
                  setState(() {
                    answer3 = _checkAnswer(answers[2]);
                  });
                }
              },
              child: Text(
                answers[2],
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: answer4 == null
                    ? null
                    : answer4!
                        ? Colors.green
                        : Colors.red,
              ),
              onPressed: () {
                if (!isAnswered) {
                  setState(() {
                    answer4 = _checkAnswer(answers[3]);
                  });
                }
              },
              child: Text(
                answers[3],
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 30),
            isAnswered
                ? ElevatedButton(
                    onPressed: () {
                      widget.getNextQuestion();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 60, 188, 248),
                    ),
                    child: Text(
                      'Continuar',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                  )
                : const Center(),
          ],
        ),
      ),
    );
  }
}
