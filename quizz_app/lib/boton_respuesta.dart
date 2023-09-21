import 'package:flutter/material.dart';

import 'controlador/controlador.dart';

class BotonRespuesta extends StatelessWidget {
  final Function() mostrarSiguientePregunta;
  final String respuesta;

  const BotonRespuesta(this.mostrarSiguientePregunta, this.respuesta, {super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
              onPressed: () {
                Controlador.almacenarRespuesta(respuesta);
                mostrarSiguientePregunta();
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                backgroundColor: const Color.fromARGB(178, 238, 159, 250),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                side: const BorderSide(
                  color: Colors.green,
                ),
              ),
              child: Text(
                respuesta,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            );
  }

}