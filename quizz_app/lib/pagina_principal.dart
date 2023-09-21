import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizz_app/pagina_preguntas.dart';

class PaginaPrincipal extends StatelessWidget {
  final Function(Widget pagina) cambiarPagina;

  const PaginaPrincipal (this.cambiarPagina, {super.key});
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.purple,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/imgs/quiz-logo.png',
              width: 300,
              color: const Color.fromARGB(150, 255, 255, 255),
            ),
            const SizedBox(
              height: 100,
            ),
            Text(
              'Aprende Flutter con este quiz',
              style: GoogleFonts.lato(
                fontSize: 25,
                color: Colors.white,
              )
            ),
            const SizedBox(
              height: 50,
            ),
            OutlinedButton.icon(
              onPressed: () {
                cambiarPagina(PaginaPreguntas(cambiarPagina));
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  color: Colors.green,
                ),
              ),
              icon: const Icon(Icons.arrow_right_alt),
              label: const Text(
                'Empezar Quiz',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}