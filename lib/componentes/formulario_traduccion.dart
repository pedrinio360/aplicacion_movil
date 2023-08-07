
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modelos/traduccion.dart';
import '../servicios/database.dart';

class FormularioTraduccion extends StatefulWidget {
  String lenguajeInicial;
  String lenguajeObjetivo;
  TextEditingController inicialTextController;
  TextEditingController objetivoTextController;

  FormularioTraduccion({
    super.key,
    required String this.lenguajeInicial,
    required String this.lenguajeObjetivo,
    required TextEditingController this.inicialTextController,
    required TextEditingController this.objetivoTextController
  });

  @override
  State<FormularioTraduccion> createState() => _FormularioTraduccionState();
}

class _FormularioTraduccionState extends State<FormularioTraduccion> {

  late DatabaseService databaseService = DatabaseService();
  late Future<List<Traduccion>> traducciones;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.inicialTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Ingrese el texto a traducir",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    String? translatedText = await traducir(
                        widget.inicialTextController.text,
                        widget.lenguajeInicial,
                        widget.lenguajeObjetivo
                    );

                    if(translatedText != null) {
                      widget.objetivoTextController.text = translatedText!;
                      Traduccion traduccion = Traduccion.empty();
                      traduccion.source = widget.inicialTextController.text;
                      traduccion.target = translatedText;
                      await databaseService.agregarTraduccion(traduccion);
                    }
                    setState(() {});
                  },
                  child: const Text('Traducir'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.objetivoTextController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Traduccion",
                  ),
                  readOnly: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(children: <Widget>[
            Expanded(
                child: Divider(
                  color: Colors.black,
                )),
          ]),
        ],
    );
  }

  Future<String?> traducir(String text, String source, String target) async {
    String url = 'http://10.0.2.2:5000/';
    url += source == 'Español' ? 'espanol-kichwa/' : 'kichwa-espanol/';

    final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"texto": text})
    );

    if(response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }
}
