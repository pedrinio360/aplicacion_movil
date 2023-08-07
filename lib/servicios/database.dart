
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../modelos/traduccion.dart';

class DatabaseService {

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, "traducciones.db"),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE traducciones (id INTEGER PRIMARY KEY AUTOINCREMENT, source TEXT NOT NULL, target TEXT NOT NULL )");
      },
      version: 1
    );
  }

  Future<void> agregarTraduccion(Traduccion traduccion) async {
    final Database db = await initializeDB();
    Traduccion? traduccionExiste = await obtenerTraduccion(traduccion.source, traduccion.target);
    if(traduccionExiste == null) {
      await db.insert('traducciones', traduccion.toMap());
    }
  }

  Future<List<Traduccion>> obtenerTraducciones() async {
    final Database db = await initializeDB();
    List<Map<String, dynamic>> result = await db.query('traducciones');
    return result.map((e) => Traduccion.fromMap(e)).toList();
  }

  Future<Traduccion?> obtenerTraduccion(String origen, String destino ) async{
    final Database db = await initializeDB();
    List<Map<String, dynamic>> result  = await db.query('traducciones', where: 'source= ? AND target=?', whereArgs: [origen, destino]);
    if(result.isNotEmpty) {
      return Traduccion.fromMap(result.first);
    }
    return null;
  }

  Future<void> eliminarTraduccion(int id) async {
    final Database db = await initializeDB();
    db.delete('traducciones', where: 'id= ?', whereArgs: [id]);
  }
}