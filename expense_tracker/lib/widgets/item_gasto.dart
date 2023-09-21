import 'package:flutter/material.dart';

import '../modelo/gasto.dart';

class ItemGasto extends StatelessWidget {
  final Gasto gasto;

  const ItemGasto(this.gasto, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
          child: Column(
            children: [
              Text(
                gasto.nombre,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(
                height: 4,
              ),
              Row(
                children: [
                  Text(
                    '${gasto.cantidad.toStringAsFixed(2)}€',
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        iconosCategorias[gasto.categoria],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        gasto.fechaFormateada,
                      )
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
