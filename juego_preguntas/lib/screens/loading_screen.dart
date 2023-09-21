import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:juego_preguntas/providers/current_screen_provider.dart';
import 'package:juego_preguntas/providers/players_names_provider.dart';
import 'package:juego_preguntas/screens/question_screen.dart';

class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  ConsumerState<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  String loadingText = 'Cargando';
  late Timer timer;
  final duration = const Duration(seconds: 1);
  int cont = 0;

  void startTimer() {
    timer = Timer.periodic(duration, (timer) {
      if (cont == 5) {
        ref
            .read(currentScreenProvider.notifier)
            .setCurrentScreen(const QuestionScreen());
      } else {
        setState(() {
          cont++;
          if (loadingText == 'Cargando...') {
            loadingText = 'Cargando';
          } else {
            loadingText = '$loadingText.';
          }
        });
      }
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
