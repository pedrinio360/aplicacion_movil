class Traduccion {
  int id = 0;
  String source = '';
  String target = '';

  Traduccion.empty();

  Traduccion({required this.id, required this.source, required this.target});

  Traduccion.fromMap(Map<String, dynamic> item):
        id=item["id"], source=item["source"], target=item["target"];

  Map<String, Object> toMap(){
    return {'source': source, 'target': target};
  }
}
