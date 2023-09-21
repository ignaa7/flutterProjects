import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:juego_preguntas/providers/current_screen_provider.dart';
import 'package:juego_preguntas/providers/players_names_provider.dart';
import 'package:juego_preguntas/screens/loading_screen.dart';

class NamesSelectionScreen extends ConsumerStatefulWidget {
  const NamesSelectionScreen({super.key});

  @override
  ConsumerState<NamesSelectionScreen> createState() =>
      _NamesSelectionScreenState();
}

class _NamesSelectionScreenState extends ConsumerState<NamesSelectionScreen> {
  String player = 'Jugador 1';
  TextEditingController playerNameController = TextEditingController();
  late Timer timer;

  @override
  void dispose() {
    playerNameController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(player),
        ),
        body: LayoutBuilder(builder: (ctx, constraints) {
          return SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 120, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text('Introduzca el nombre del $player:'),
                      const SizedBox(height: 60),
                      TextField(
                        controller: playerNameController,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          label: Text('Nombre'),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(playersNamesProvider.notifier).setPlayer(
                              player, playerNameController.text.trim());
                          if (player == 'Jugador 1') {
                            setState(() {
                              player = 'Jugador 2';
                              playerNameController.text = '';
                            });
                          } else {
                            Duration duration = const Duration(seconds: 1);
                            FocusScope.of(context).unfocus();
                            timer = Timer.periodic(duration, (timer) {
                              ref
                                  .read(currentScreenProvider.notifier)
                                  .setCurrentScreen(const LoadingScreen());
                            });
                          }
                        },
                        child: const Text('Continuar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
