import 'package:flutter/material.dart';

class EndScreen extends StatelessWidget {
  final String player;

  const EndScreen(this.player, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 120, horizontal: 20),
          child: Text('¡$player ha ganado!'),
        ),
      ),
    );
  }
}
