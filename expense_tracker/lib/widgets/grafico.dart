import 'package:expense_tracker/widgets/barra_grafico.dart';
import 'package:flutter/material.dart';

import '../modelo/gasto.dart';

class Grafico extends StatefulWidget {
  final List<Gasto> gastos;

  const Grafico(this.gastos, {super.key});

  @override
  State<Grafico> createState() => _GraficoState();
}

class _GraficoState extends State<Grafico> {
  int? numMaxGastosCategoria;

  _GraficoState() {
    for (Categoria categoria in Categoria.values) {
      int numGastos = _GraficoState().obtenerNumGastosCategoria(categoria);
      if (numMaxGastosCategoria == null) {
        numMaxGastosCategoria = numGastos;
      } else if (numGastos > numMaxGastosCategoria!) {
        numMaxGastosCategoria = numGastos;
      }
    }
  }

  List<Gasto> obtenerGastosCategoria(Categoria categoria) {
    List<Gasto> gastosCategoria = [];

    for (Gasto gasto in widget.gastos) {
      if (gasto.categoria == categoria) gastosCategoria.add(gasto);
    }

    return gastosCategoria;
  }

  int obtenerNumGastosCategoria(Categoria categoria) {
    int numGastos = 0;

    for (Gasto gasto in widget.gastos) {
      if (gasto.categoria == categoria) numGastos++;
    }

    return numGastos;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (Categoria categoria in Categoria.values)
                  BarraGrafico(
                    obtenerNumGastosCategoria(categoria) == 0
                        ? 0
                        : obtenerNumGastosCategoria(categoria) /
                            numMaxGastosCategoria!,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: Categoria.values
                .map(
                  (categoria) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        iconosCategorias[categoria],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
