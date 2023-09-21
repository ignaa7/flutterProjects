import 'package:app_comidas/datos/datos.dart';
import 'package:app_comidas/pantallas/pantalla_comidas_categoria.dart';
import 'package:app_comidas/widgets/categoria_item.dart';
import 'package:flutter/material.dart';

class PantallaCategorias extends StatefulWidget {
  const PantallaCategorias({
    super.key,
  });

  @override
  State<PantallaCategorias> createState() => _PantallaCategoriasState();
}

class _PantallaCategoriasState extends State<PantallaCategorias>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
      lowerBound: 0, //default
      upperBound: 1, //default
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _mostrarPantallaComidas(
    BuildContext context, {
    required String id,
    required String titulo,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => PantallaComidasCategoria(
          id: id,
          titulo: titulo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final categoria in categoriasDisponibles)
            CategoriaItem(
                categoria: categoria,
                mostrarPantallaComidas: _mostrarPantallaComidas)
        ],
      ),
      builder: (context, child) => SlideTransition(
        position: Tween(
          begin: const Offset(0, 0.3),
          end: const Offset(0, 0),
        ).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeInOut,
          ),
        ),
        child: child,
      ),
    );
  }
}
