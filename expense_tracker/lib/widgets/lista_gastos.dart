import 'package:expense_tracker/widgets/item_gasto.dart';
import 'package:flutter/material.dart';

import '../modelo/gasto.dart';

class ListaGastos extends StatelessWidget {
  final List<Gasto> gastos;
  final void Function(Gasto gasto) eliminarGasto;

  const ListaGastos({
    super.key,
    required this.gastos,
    required this.eliminarGasto,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: gastos.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(gastos[index]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
            horizontal: Theme.of(context).cardTheme.margin!.horizontal,
          ),
        ),
        onDismissed: (direccion) {
          eliminarGasto(gastos[index]);
        },
        child: ItemGasto(gastos[index]),
      ),
    );
  }
}
