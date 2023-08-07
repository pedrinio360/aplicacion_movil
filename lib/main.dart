import 'package:flutter/material.dart';
import 'package:kichwa_translator/pantallas/pagina_principal.dart';

void main() {
  runApp(const TraductorApp());
}

class TraductorApp extends StatelessWidget {
  const TraductorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen
      ),
      home: const PaginaPrincipal(
        titulo: 'Traductor Español - Kichwa'
      ),
    );
  }
}
