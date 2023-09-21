import 'package:quizz_app/modelo/pregunta.dart';

class Controlador {
  static List<Pregunta> preguntas = [
    Pregunta('What are the main building blocks of Flutter UIs?', 'Widgets', 'Components', 'Blocks', 'Functions'),
    Pregunta('How are Flutter UIs built?', 'By combining widgets in code', 'By combining widgets in a visual editor', 'By defining widgets in config files', 'By using XCode for iOS and Android Studio for Android'),
    Pregunta('What\'s the purpose of a StatefulWidget?', 'Update UI as data changes', 'Update data as UI changes', 'Ignore data changes', 'Render UI that does not depend on data'),
    Pregunta('Which widget should you try to use more often: StatelessWidget or StatefulWidget?', 'StatelessWidget', 'StatefulWidget', 'Both are equally good', 'None of the above'),
    Pregunta('What happens if you change data in a StatelessWidget?', 'The UI is not updated', 'The UI is updated', 'The closest StatefulWidget is updated', 'Any nested StatefulWidgets are updated'),
    Pregunta('How should you update data inside of StatefulWidgets?', 'By calling setState()', 'By calling updateData()', 'By calling updateUI()', 'By calling updateState()')
  ];
  static int cont = 0;
  static late Pregunta preguntaActual;
  static int numPreguntasAcertadas = 0;

  static Pregunta getPregunta() {
    Pregunta pregunta = preguntas[cont];
    preguntaActual = pregunta;
    cont++;

    return pregunta;
  }

  static List<Pregunta> getPreguntas() {
    return preguntas;
  }

  static void almacenarRespuesta(String respuesta) {
    preguntaActual.respuestaUsuario = respuesta;
    if (respuesta == preguntaActual.respuestaCorrecta) numPreguntasAcertadas++;
  }
}
