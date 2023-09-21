import 'package:app_comidas/widgets/caracteristica_comida_item.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../modelo/comida.dart';

class ComidaItem extends StatelessWidget {
  final Comida comida;
  final Function mostrarPantallaDetalles;

  const ComidaItem(this.comida, this.mostrarPantallaDetalles, {super.key});

  String capitalize(String texto) {
    return texto[0].toUpperCase() + texto.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          mostrarPantallaDetalles(context, comida);
        },
        child: Stack(
          children: [
            Hero(
              tag: comida.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(comida.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 44,
                ),
                child: Column(
                  children: [
                    Text(
                      comida.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CaracteristicaComidaItem(
                          icono: Icons.schedule,
                          label: '${comida.duration} min',
                        ),
                        const SizedBox(width: 12),
                        CaracteristicaComidaItem(
                          icono: Icons.work,
                          label: capitalize(comida.complexity.name),
                        ),
                        const SizedBox(width: 12),
                        CaracteristicaComidaItem(
                          icono: Icons.attach_money,
                          label: capitalize(comida.affordability.name),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
