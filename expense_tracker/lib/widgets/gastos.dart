import 'package:expense_tracker/widgets/grafico.dart';
import 'package:expense_tracker/widgets/lista_gastos.dart';
import 'package:expense_tracker/widgets/pantalla_agregar_gasto.dart';
import 'package:flutter/material.dart';

import '../modelo/gasto.dart';

class Gastos extends StatefulWidget {
  const Gastos({super.key});

  @override
  State<Gastos> createState() {
    return _GastosState();
  }
}

class _GastosState extends State<Gastos> {
  final Widget mensajeContenidoVacio = const Center(
    child: Text('No existe ningún gasto añadido'),
  );
  final List<Gasto> _gastosRegistrados = [
    Gasto(
      nombre: 'Curso Flutter',
      cantidad: 16.99,
      fecha: DateTime.now(),
      categoria: Categoria.trabajo,
    ),
    Gasto(
      nombre: 'Juego Dave The Diver',
      cantidad: 19.99,
      fecha: DateTime.now(),
      categoria: Categoria.ocio,
    ),
  ];

  void _mostrarPantallaAgregarGasto() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width >
                  MediaQuery.of(context).size.height
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.height),
      builder: (ctx) => PantallaAgregarGasto(_guardarGasto),
    );
  }

  void _guardarGasto(Gasto gasto) {
    setState(() {
      _gastosRegistrados.add(gasto);
    });
  }

  void _eliminarGasto(Gasto gasto) {
    final indice = _gastosRegistrados.indexOf(gasto);
    setState(() {
      _gastosRegistrados.remove(gasto);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Gasto eliminado'),
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: () {
            setState(() {
              _gastosRegistrados.insert(indice, gasto);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestor de gastos'),
        actions: [
          IconButton(
            onPressed: _mostrarPantallaAgregarGasto,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Grafico(_gastosRegistrados),
                Expanded(
                  child: _gastosRegistrados.isEmpty
                      ? mensajeContenidoVacio
                      : ListaGastos(
                          gastos: _gastosRegistrados,
                          eliminarGasto: _eliminarGasto,
                        ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Grafico(_gastosRegistrados),
                ),
                Expanded(
                  child: _gastosRegistrados.isEmpty
                      ? mensajeContenidoVacio
                      : ListaGastos(
                          gastos: _gastosRegistrados,
                          eliminarGasto: _eliminarGasto,
                        ),
                ),
              ],
            ),
    );
  }
}
