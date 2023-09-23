import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:juego_preguntas/providers/players_names_provider.dart';
import 'package:juego_preguntas/screens/end_screen.dart';
import 'package:juego_preguntas/widgets/question_widget.dart';

import '../providers/current_screen_provider.dart';
import 'package:http/http.dart' as http;

const urlStart = 'preguntas-backend-default-rtdb.firebaseio.com';

class QuestionScreen extends ConsumerStatefulWidget {
  const QuestionScreen({super.key});

  @override
  ConsumerState<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends ConsumerState<QuestionScreen> {
  final questionsNumber = 126;
  // late List<dynamic> questions;
  late Map<String, dynamic> question;
  final List<int> usedNumbers = [];
  final random = Random();
  var isLoaded = false;
  String currentPlayer = 'Jugador 1';
  late Map<String, dynamic> playersNames;

  // void _getQuestions() async {
  //   final response = await rootBundle.loadString('assets/preguntas.json');

  //   setState(() {
  //     questions = jsonDecode(response);
  //     isLoaded = true;
  //     _getNextQuestion();
  //   });
  // }

  void _changePlayer() {
    if (currentPlayer == 'Jugador 1') {
      currentPlayer = 'Jugador 2';
    } else {
      currentPlayer = 'Jugador 1';
    }
  }

  @override
  void initState() {
    super.initState();
    // _getQuestions();
  }

  void _getNextQuestion() async {
    int number;
    bool isNewNumber = false;

    _checkVictory();

    do {
      number = random.nextInt(questionsNumber);

      if (!usedNumbers.contains(number)) {
        usedNumbers.add(number);
        isNewNumber = true;
      }
    } while (!isNewNumber);

    final url = Uri.https(urlStart, '$number.json');

    final response = await http.get(url);

    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        context.mounted) {
      setState(() {
        question = json.decode(response.body);
        _changePlayer();
        isLoaded = true;
      });
    }
  }

  void _checkVictory() {
    if (playersNames['Jugador 2']['score'] == 3) {
      ref
          .read(currentScreenProvider.notifier)
          .setCurrentScreen(EndScreen(playersNames['Jugador 2']['name']));
    } else if (playersNames['Jugador 1']['score'] == 3) {
      ref
          .read(currentScreenProvider.notifier)
          .setCurrentScreen(EndScreen(playersNames['Jugador 1']['name']));
    }
  }

  @override
  Widget build(BuildContext context) {
    playersNames = ref.watch(playersNamesProvider);

    if (!isLoaded) {
      _getNextQuestion();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(playersNames[currentPlayer]['name']!),
      ),
      body: isLoaded
          ? Column(
              children: [
                QuestionWidget(
                  question: question,
                  getNextQuestion: _getNextQuestion,
                  currentPlayer: currentPlayer,
                ),
                const SizedBox(height: 40),
                Text(
                  '${playersNames['Jugador 1']['name']} : ${playersNames['Jugador 1']['score']}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 20),
                Text(
                  '${playersNames['Jugador 2']['name']} : ${playersNames['Jugador 2']['score']}',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
