import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app/pagina_principal.dart';
import 'package:quizz_app/respuesta.dart';

import 'controlador/controlador.dart';
import 'modelo/pregunta.dart';

class PaginaResultados extends StatelessWidget {
  final Function(Widget pagina) cambiarPagina;

  const PaginaResultados(this.cambiarPagina, {super.key});

  @override
  Widget build(BuildContext context) {
    List<Pregunta> preguntas = Controlador.getPreguntas();
    int numPreguntasAcertadas = Controlador.numPreguntasAcertadas;
    int numPreguntas = Controlador.preguntas.length;

    return Container(
      decoration: const BoxDecoration(color: Color.fromARGB(255, 75, 187, 240)),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Has acertado $numPreguntasAcertadas de $numPreguntas preguntas',
                textAlign: TextAlign.center,
                style: GoogleFonts.kanit(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                  height: 20,
                ),
              SizedBox(
                height: 400,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ...preguntas.map((pregunta) {
                        return Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Respuesta(pregunta.textoPregunta, pregunta.respuestaUsuario, pregunta.respuestaCorrecta, pregunta.numPregunta),
                        );
                      }),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                  height: 30,
                ),
              TextButton.icon(
                onPressed: () {
                  Controlador.cont = 0;
                  Controlador.numPreguntasAcertadas = 0;
                  Pregunta.cont = 0;
                  cambiarPagina(PaginaPrincipal(cambiarPagina));
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.purple,
                ),
                label: const Text(
                  'Volver a empezar',
                  style: TextStyle(
                    color: Colors.purple,
                    fontSize: 18
                  ),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
