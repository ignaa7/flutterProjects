import 'package:app_comidas/pantallas/pantalla_detalles_comida.dart';
import 'package:app_comidas/widgets/comida_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../modelo/comida.dart';
import '../providers/filters_provider.dart';

class PantallaComidasCategoria extends ConsumerStatefulWidget {
  final String? id;
  final String? titulo;
  final List<Comida>? comidasFavoritas;

  const PantallaComidasCategoria({
    super.key,
    this.id,
    this.titulo,
    this.comidasFavoritas,
  });

  @override
  ConsumerState<PantallaComidasCategoria> createState() =>
      _PantallaComidasCategoriaState();
}

class _PantallaComidasCategoriaState
    extends ConsumerState<PantallaComidasCategoria> {
  void _mostrarPantallaDetalles(
    BuildContext context,
    Comida comida,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => PantallaDetallesComida(
          comida: comida,
        ),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Comida> comidasCategoria = [];

    if (widget.id == null) {
      comidasCategoria = widget.comidasFavoritas!;
    } else {
      comidasCategoria = ref.watch(filteredMealsProvider(widget.id!));
    }

    Widget contenido = ListView.builder(
      itemCount: comidasCategoria.length,
      itemBuilder: (ctx, index) => ComidaItem(
        comidasCategoria[index],
        _mostrarPantallaDetalles,
      ),
    );

    if (comidasCategoria.isEmpty) {
      contenido = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No hay ninguna comida disponible',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    Widget pagina = contenido;

    if (widget.titulo != null) {
      pagina = Scaffold(
        appBar: AppBar(
          title: Text(widget.titulo!),
        ),
        body: contenido,
      );
    }

    return pagina;
  }
}
