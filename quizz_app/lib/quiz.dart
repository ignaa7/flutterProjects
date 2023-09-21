import 'package:flutter/material.dart';
import 'package:quizz_app/pagina_principal.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  late Widget paginaActual;

  void _cambiarPagina(Widget pagina) {
    setState(() {
      paginaActual = pagina;
    });
  }

  @override
  void initState() {
    super.initState();

    paginaActual = PaginaPrincipal(_cambiarPagina);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: paginaActual,
      ),
    );
  }}