import 'package:app_comidas/datos/datos.dart';
import 'package:app_comidas/modelo/comida.dart';
import 'package:app_comidas/providers/favorites_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PantallaDetallesComida extends ConsumerStatefulWidget {
  final Comida comida;

  const PantallaDetallesComida({
    super.key,
    required this.comida,
  });

  @override
  ConsumerState<PantallaDetallesComida> createState() =>
      _PantallaDetallesComidaState();
}

class _PantallaDetallesComidaState
    extends ConsumerState<PantallaDetallesComida> {
  String showArray(List<String> array) {
    String texto = '';
    for (String element in array) {
      if (element != array[0]) texto += '\n';
      texto += '-$element';
    }
    return texto;
  }

  String showArrayCategorias(List<String> array) {
    String texto = '';
    for (String id in array) {
      String titulo = categoriasDisponibles
          .where((categoria) => categoria.id == id)
          .toList()[0]
          .titulo;
      if (id != array[0]) texto += '\n';
      texto += '-$titulo';
    }
    return texto;
  }

  String capitalize(String texto) {
    return texto[0].toUpperCase() + texto.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(widget.comida);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.comida.title),
        actions: [
          IconButton(
            onPressed: () {
              bool agregada = ref
                  .read(favoriteMealsProvider.notifier)
                  .cambiarFavorita(widget.comida);

              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    agregada
                        ? 'Meal added to favorites.'
                        : 'Meal deleted from favorites.',
                  ),
                ),
              );
              setState(() {});
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                  turns: Tween<double>(
                    begin: 0.5,
                    end: 1,
                  ).animate(animation),
                  child: child,
                );
              },
              child: Icon(
                Icons.star,
                color: isFavorite ? Colors.green : Colors.white,
                key: ValueKey(isFavorite),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Hero(
                tag: widget.comida.id,
                child: Image.network(
                  widget.comida.imageUrl,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Categories',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                showArrayCategorias(widget.comida.categories),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(height: 30),
              Text(
                'Affordability',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                capitalize(widget.comida.affordability.name),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(height: 30),
              Text(
                'Complexity',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                capitalize(widget.comida.complexity.name),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(height: 30),
              Text(
                'Duration',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                '${widget.comida.duration} min',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(height: 30),
              Text(
                'Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                showArray(widget.comida.ingredients),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(height: 30),
              Text(
                'Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                showArray(widget.comida.steps),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              const SizedBox(height: 30),
              Text(
                'Labels',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              if (widget.comida.isGlutenFree)
                Text(
                  'Gluten Free',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              if (widget.comida.isVegan)
                Text(
                  'Vegan',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              if (widget.comida.isVegetarian)
                Text(
                  'Vegetarian',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              if (widget.comida.isLactoseFree)
                Text(
                  'Lactose Free',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
              if (!widget.comida.isGlutenFree &&
                  !widget.comida.isVegan &&
                  !widget.comida.isVegetarian &&
                  !widget.comida.isLactoseFree)
                Text(
                  'No labels',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
