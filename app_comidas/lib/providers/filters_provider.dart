import 'package:app_comidas/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../modelo/comida.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>(
        (ref) => FiltersNotifier());

final filteredMealsProvider = ProviderFamily<List<Comida>, String>((ref, id) {
  final comidasDisponibles = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  final comidasFiltradas = comidasDisponibles.where((comida) {
    bool esCorrecta = true;
    if (!comida.categories.contains(id)) {
      esCorrecta = false;
    } else if (activeFilters[Filter.glutenFree]! && !comida.isGlutenFree) {
      esCorrecta = false;
    } else if (activeFilters[Filter.lactoseFree]! && !comida.isLactoseFree) {
      esCorrecta = false;
    } else if (activeFilters[Filter.vegetarian]! && !comida.isVegetarian) {
      esCorrecta = false;
    } else if (activeFilters[Filter.vegan]! && !comida.isVegan) {
      esCorrecta = false;
    }
    return esCorrecta;
  }).toList();

  return comidasFiltradas;
});
