import 'package:expense_tracker/modelo/gasto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PantallaAgregarGasto extends StatefulWidget {
  final void Function(Gasto gasto) guardarGasto;

  const PantallaAgregarGasto(this.guardarGasto, {super.key});

  @override
  State<PantallaAgregarGasto> createState() => _PantallaAgregarGastoState();
}

class _PantallaAgregarGastoState extends State<PantallaAgregarGasto> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  DateTime? _fechaElegida;
  Categoria? _categoriaElegida;

  void _mostrarDatePicker() async {
    final DateTime fechaHoy = DateTime.now();
    final DateTime fechaInicio =
        DateTime(fechaHoy.year - 1, fechaHoy.month, fechaHoy.day);

    final fechaSeleccionada = await showDatePicker(
      context: context,
      initialDate: _fechaElegida == null ? fechaHoy : _fechaElegida!,
      firstDate: fechaInicio,
      lastDate: fechaHoy,
    );

    setState(() {
      if (fechaSeleccionada != null) _fechaElegida = fechaSeleccionada;
    });
  }

  void _almacenarGasto() {
    String nombre = _nombreController.text.trim();
    double? cantidad = double.tryParse(_cantidadController.text.trim());
    DateTime? fecha = _fechaElegida;
    Categoria? categoria = _categoriaElegida;

    if (nombre.isNotEmpty &&
        cantidad != null &&
        fecha != null &&
        categoria != null) {
      Gasto gasto = Gasto(
          nombre: nombre,
          cantidad: cantidad,
          fecha: fecha,
          categoria: categoria);
      widget.guardarGasto(gasto);
      Navigator.pop(context);
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Datos inválidos'),
          content: const Text('Rellene todos los campos'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final espacioTeclado = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, espacioTeclado + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _nombreController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text('Nombre'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: TextField(
                          controller: _cantidadController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'(^\d*(\.\d?\d?)?)')),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Cantidad',
                            suffixText: '€',
                          ),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _nombreController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Nombre'),
                    ),
                  ),
                const SizedBox(height: 40),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _categoriaElegida,
                        hint: const Text('Categoría'),
                        items: Categoria.values
                            .map(
                              (categoria) => DropdownMenuItem(
                                value: categoria,
                                child: Text(
                                  categoria.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (categoria) {
                          if (categoria != null) {
                            setState(() {
                              _categoriaElegida = categoria;
                            });
                          }
                        },
                      ),
                      const SizedBox(width: 100),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_fechaElegida == null
                                ? 'Seleccione una fecha'
                                : formatter.format(_fechaElegida!)),
                            IconButton(
                              onPressed: () {
                                _mostrarDatePicker();
                              },
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar'),
                      ),
                      const SizedBox(width: 50),
                      ElevatedButton(
                        onPressed: () {
                          _almacenarGasto();
                        },
                        child: const Text('Guardar gasto'),
                      ),
                      const SizedBox(width: 50),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _cantidadController,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'(^\d*(\.\d?\d?)?)')),
                          ],
                          decoration: const InputDecoration(
                            labelText: 'Cantidad',
                            suffixText: '€',
                          ),
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(_fechaElegida == null
                                ? 'Seleccione una fecha'
                                : formatter.format(_fechaElegida!)),
                            IconButton(
                              onPressed: () {
                                _mostrarDatePicker();
                              },
                              icon: const Icon(Icons.calendar_month),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20,
                ),
                if (width < 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _categoriaElegida,
                        hint: const Text('Categoría'),
                        items: Categoria.values
                            .map(
                              (categoria) => DropdownMenuItem(
                                value: categoria,
                                child: Text(
                                  categoria.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (categoria) {
                          if (categoria != null) {
                            setState(() {
                              _categoriaElegida = categoria;
                            });
                          }
                        },
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _almacenarGasto();
                        },
                        child: const Text('Guardar gasto'),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
