import 'package:flutter/material.dart';

class CaracteristicaComidaItem extends StatelessWidget {
  final IconData icono;
  final String label;

  const CaracteristicaComidaItem({
    super.key,
    required this.icono,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icono,
          size: 17,
          color: Colors.white,
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
