import 'dart:math';

import 'package:flutter/material.dart';

final random = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});
  
  @override
  State<DiceRoller> createState() {
    return _DiceRollerState();
  }

}

class _DiceRollerState extends State<DiceRoller> {
  var num = 1;

  @override
  Widget build(context) {
    return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/imgs/dice-$num.png',
                    width: 200,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        num = random.nextInt(6) + 1;
                      });
                    },
                    icon: Image.asset('assets/imgs/roll.png'),
                    iconSize: 150,
                  )
                ],
              );
  }

}