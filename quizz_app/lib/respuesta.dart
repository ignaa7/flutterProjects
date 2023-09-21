import 'package:flutter/material.dart';

class Respuesta extends StatelessWidget {
  final String textoPregunta, respuestaUsuario, respuestaCorrecta;
  final int numPregunta;

  const Respuesta(this.textoPregunta, this.respuestaUsuario, this.respuestaCorrecta, this.numPregunta, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
          child: Text(
          numPregunta.toString(),
          style: const TextStyle(
            fontSize: 15,
          ),
        ),
        ),
        Expanded(
          child: Column(
            children: [
              Text(
                textoPregunta,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                respuestaUsuario,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: respuestaUsuario == respuestaCorrecta ? const Color.fromARGB(255, 1, 146, 6) : Colors.red,
                  fontSize: 15,
                ),
              ),
              Text(
                respuestaCorrecta,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color.fromARGB(255, 0, 106, 155),
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

}