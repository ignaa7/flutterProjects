class Pregunta {
  String textoPregunta;
  late List<String> respuestas;
  late String respuestaCorrecta;
  late String respuestaUsuario;
  late int numPregunta;
  static int cont = 1;

  Pregunta(this.textoPregunta, String respuesta1, String respuesta2, String respuesta3, String respuesta4) {
    respuestas = [respuesta1, respuesta2, respuesta3, respuesta4];
    respuestaCorrecta = respuesta1;
    numPregunta = cont;
    cont++;
  }
}