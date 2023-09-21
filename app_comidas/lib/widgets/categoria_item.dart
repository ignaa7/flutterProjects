import 'package:app_comidas/modelo/categoria.dart';
import 'package:flutter/material.dart';

class CategoriaItem extends StatelessWidget {
  final Categoria categoria;
  final Function mostrarPantallaComidas;

  const CategoriaItem({
    super.key,
    required this.categoria,
    required this.mostrarPantallaComidas,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        mostrarPantallaComidas(
          context,
          id: categoria.id,
          titulo: categoria.titulo,
        );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              categoria.color.withOpacity(0.55),
              categoria.color.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          categoria.titulo,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
