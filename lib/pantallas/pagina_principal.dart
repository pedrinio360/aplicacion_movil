import 'package:flutter/material.dart';
import 'package:kichwa_translator/componentes/formulario_traduccion.dart';
import 'package:kichwa_translator/componentes/lista_traducciones.dart';
import '../componentes/seleccion_lenguaje.dart';

class PaginaPrincipal extends StatefulWidget {
  final String titulo;

  const PaginaPrincipal({super.key, required this.titulo});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  String lenguajeInicial = 'Español';
  String lenguajeObjetivo = 'Kichwa';
  TextEditingController inicialTextController = TextEditingController();
  TextEditingController objetivoTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: crearBarraSuperior(),
      body: crearContenedorPrincipal(),
    );
  }

  PreferredSizeWidget crearBarraSuperior() {
    return AppBar(
      centerTitle: true,
      title: Text(
          widget.titulo,
          style: const TextStyle(color: Colors.white)
      ),
    );
  }

  Widget crearContenedorPrincipal() {
    return Container(
      padding: const EdgeInsets.all(5),
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints ) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight
                  ),
                  child: IntrinsicHeight(
                      child: Column(
                          children: [
                            SeleccionLenguaje(
                                lenguajeInicial: lenguajeInicial,
                                lenguajeObjetivo: lenguajeObjetivo,
                                cambiarLenguaje: intercambiarLenguajes
                            ),
                            FormularioTraduccion(
                                lenguajeInicial: lenguajeInicial,
                                lenguajeObjetivo: lenguajeObjetivo,
                                inicialTextController: inicialTextController,
                                objetivoTextController: objetivoTextController
                            ),
                            Expanded(
                                child: SizedBox(
                                  height: viewportConstraints.maxHeight / 2,
                                  child: const ListaTraducciones(),
                                )
                            )
                          ],
                      )
                  ),
                ),
              );
          },
      ),
    );
  }

  void intercambiarLenguajes() {
    String lenguajeTemporal = lenguajeInicial;
    setState(() {
      lenguajeInicial = lenguajeObjetivo;
      lenguajeObjetivo = lenguajeTemporal;
    });
    inicialTextController.text = '';
    objetivoTextController.text = '';
  }
}
