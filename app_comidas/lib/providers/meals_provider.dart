import 'package:app_comidas/datos/datos.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealsProvider = Provider((ref) {
  return comidas;
});
