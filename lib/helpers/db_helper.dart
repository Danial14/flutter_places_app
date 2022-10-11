import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
class DbHelper{
  /*static Future<sql.Database> database() async{
    final dbpath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbpath, "places.db"), onCreate: (db, version){
      return db.execute('CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT)');
    }, version: 1);
  }
  static Future<void> insert(String table, Map<String, Object> data) async{
    final db = await DbHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }*/
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    print("dbpath: ${dbPath}");
    String st = path.join(dbPath, 'places.db');
    print("st: ${st}");
    return sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
          return db.execute(
              'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
        }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbHelper.database();
   await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
  static Future<List<Map<String, Object?>>> fetchData(String table) async{
    final db = await DbHelper.database();
    return db.query(table);
  }
  static Future<int> delete(String table, String id) async{
    final db = await DbHelper.database();
    return db.delete(table, where: "id = ?", whereArgs: [id]);
  }
}