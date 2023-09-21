import 'package:app_comidas/pantallas/pantalla_categorias.dart';
import 'package:app_comidas/pantallas/pantalla_comidas_categoria.dart';
import 'package:app_comidas/pantallas/pantalla_filtros.dart';
import 'package:app_comidas/providers/favorites_provider.dart';
import 'package:app_comidas/widgets/main_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filters_provider.dart';

class PantallaPestanas extends ConsumerStatefulWidget {
  const PantallaPestanas({super.key});

  @override
  ConsumerState<PantallaPestanas> createState() {
    return _PantallaPestanasState();
  }
}

class _PantallaPestanasState extends ConsumerState<PantallaPestanas> {
  int _paginaSeleccionada = 0;

  void seleccionarPagina(int index) {
    setState(() {
      _paginaSeleccionada = index;
    });
  }

  void _establecerPantalla(String identifier) async {
    Navigator.pop(context);

    if (identifier == 'filters') {
      await Navigator.push<Map<Filter, bool>>(
        context,
        MaterialPageRoute(builder: (ctx) => const PantallaFiltros()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget paginaActual = const PantallaCategorias();
    String titulo = 'Categories';

    if (_paginaSeleccionada == 1) {
      final comidasFavoritas = ref.watch(favoriteMealsProvider);
      paginaActual = PantallaComidasCategoria(
        comidasFavoritas: comidasFavoritas,
      );
      titulo = 'Your Favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      drawer: MainDrawer(_establecerPantalla),
      body: paginaActual,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          seleccionarPagina(index);
        },
        currentIndex: _paginaSeleccionada,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
