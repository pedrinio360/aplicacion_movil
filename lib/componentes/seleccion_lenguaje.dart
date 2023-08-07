import 'package:flutter/material.dart';

class SeleccionLenguaje extends StatefulWidget {
  String lenguajeInicial;
  String lenguajeObjetivo;
  Function cambiarLenguaje;

  SeleccionLenguaje({
    super.key,
    required this.lenguajeInicial,
    required this.lenguajeObjetivo,
    required this.cambiarLenguaje
  });

  @override
  State<SeleccionLenguaje> createState() => _SeleccionLenguajeState();
}

class _SeleccionLenguajeState extends State<SeleccionLenguaje> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            child: Center(
              child: Text(widget.lenguajeInicial,
                  style: TextStyle(color: Colors.blue.shade500, fontSize: 15.0)),
            )),
        IconButton(
          icon: Icon(Icons.swap_horiz, color: Colors.grey.shade700),
          onPressed: () {
            widget.cambiarLenguaje();
          },
        ),
        Expanded(
            child: Center(
              child: Text(widget.lenguajeObjetivo,
                  style: TextStyle(color: Colors.blue.shade500, fontSize: 15.0)),
            )),
      ],
    );
  }
}
