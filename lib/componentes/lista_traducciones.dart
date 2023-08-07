import 'package:flutter/material.dart';

import '../modelos/traduccion.dart';
import '../servicios/database.dart';

class ListaTraducciones extends StatefulWidget {
  const ListaTraducciones({super.key});

  @override
  State<ListaTraducciones> createState() => _ListaTraduccionesState();
}

class _ListaTraduccionesState extends State<ListaTraducciones> {
  late DatabaseService databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: databaseService.obtenerTraducciones(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          var traducciones = snapshot.data as List<Traduccion>;
          traducciones.sort((a, b) => b.id.compareTo(a.id));
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: traducciones.length,
            itemBuilder: (context, index) {
              Traduccion traduccion = traducciones[index];
              return ListTile(
                title: Text(traduccion.source),
                subtitle: Text(traduccion.target),
                trailing: IconButton.outlined(
                    icon: const Icon(Icons.delete),
                    color: Colors.redAccent,
                    onPressed: () async {
                      await databaseService.eliminarTraduccion(traduccion.id);
                      setState(() {});
                    },
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
