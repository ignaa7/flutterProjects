import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app/boton_respuesta.dart';
import 'package:quizz_app/modelo/pregunta.dart';
import 'package:quizz_app/controlador/controlador.dart';
import 'package:quizz_app/pagina_resultados.dart';

class PaginaPreguntas extends StatefulWidget {
  final Function(Widget pagina) cambiarPagina;

  const PaginaPreguntas(this.cambiarPagina, {super.key});

  @override
  State<PaginaPreguntas> createState() => _PaginaPreguntasState();
}

class _PaginaPreguntasState extends State<PaginaPreguntas> {
  int numPregunta = 1;

  mostrarSiguientePregunta() {
    numPregunta++;
    if (numPregunta > Controlador.preguntas.length) {
      numPregunta = 1;
      widget.cambiarPagina(PaginaResultados(widget.cambiarPagina));
    }
    else {
      setState((){});
    }
  }

  @override
  Widget build(BuildContext context) {
    Pregunta pregunta = Controlador.getPregunta();
    String textoPregunta = pregunta.textoPregunta;
    List<String> respuestas = pregunta.respuestas;
    respuestas.shuffle();

    return Container(
      decoration: const BoxDecoration(color: Colors.blue),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                textoPregunta,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ...respuestas.map((respuesta) {
                return Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: BotonRespuesta(mostrarSiguientePregunta, respuesta),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
