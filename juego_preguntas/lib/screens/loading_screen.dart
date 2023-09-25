import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:juego_preguntas/providers/current_screen_provider.dart';
import 'package:juego_preguntas/providers/players_names_provider.dart';
import 'package:juego_preguntas/screens/question_screen.dart';

import 'package:http/http.dart' as http;

class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  String loadingText = 'Cargando';
  late Timer timer;
  final duration = const Duration(seconds: 1);
  var questionsFetched = false;
  late int questionsNumber;

  void startTimer() async {
    final url =
        Uri.https('preguntas-backend-default-rtdb.firebaseio.com', '.json');

    final response = await http.get(url);

    if (response.statusCode >= 200 &&
        response.statusCode < 300 &&
        context.mounted) {
      questionsNumber = json.decode(response.body).length;

      questionsFetched = true;
    }

    timer = Timer.periodic(duration, (timer) {
      if (questionsFetched) {
        ref
            .read(currentScreenProvider.notifier)
            .setCurrentScreen(QuestionScreen(questionsNumber));
      }
      setState(() {
        if (loadingText == 'Cargando...') {
          loadingText = 'Cargando';
        } else {
          loadingText = '$loadingText.';
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> playersNames = ref.read(playersNamesProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                playersNames['Jugador 1']['name']!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 50),
              Text(
                'VS',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 50),
              Text(
                playersNames['Jugador 2']['name']!,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 100),
              Text(
                loadingText,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
