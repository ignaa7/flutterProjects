import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat('dd/MM/yyyy');

const Uuid uuid = Uuid();

enum Categoria { comida, viaje, ocio, trabajo }

const iconosCategorias = {
  Categoria.comida: Icons.lunch_dining,
  Categoria.viaje: Icons.flight_takeoff,
  Categoria.ocio: Icons.movie,
  Categoria.trabajo: Icons.work,
};

class Gasto {
  final String id;
  final String nombre;
  final double cantidad;
  final DateTime fecha;
  final Categoria categoria;

  String get fechaFormateada {
    return formatter.format(fecha);
  }

  Gasto(
      {required this.nombre,
      required this.cantidad,
      required this.fecha,
      required this.categoria})
      : id = uuid.v4();
}
