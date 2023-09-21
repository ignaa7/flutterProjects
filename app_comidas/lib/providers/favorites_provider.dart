import 'package:app_comidas/modelo/comida.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Comida>> {
  FavoriteMealsNotifier() : super([]);

  bool cambiarFavorita(Comida comida) {
    var comidasFavoritas = state;
    bool agregada = true;

    if (comidasFavoritas.contains(comida)) {
      comidasFavoritas.remove(comida);
      agregada = false;
    } else {
      comidasFavoritas.add(comida);
    }

    state = comidasFavoritas;

    return agregada;
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Comida>>(
  (ref) => FavoriteMealsNotifier(),
);
