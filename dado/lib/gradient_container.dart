import 'package:dado/dice_roller.dart';
import 'package:flutter/material.dart';


const beginAlignment = Alignment.topLeft;
const endAlignment = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.colors, {super.key});

  final List<Color> colors;

  @override
  Widget build(context) {
    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: beginAlignment,
              end: endAlignment,
            ),
          ),
          child: const Center(
              child: DiceRoller(),
          ),
        );
  }
}