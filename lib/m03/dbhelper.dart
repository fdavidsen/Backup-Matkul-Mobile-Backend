import 'package:latihan_mobile_backend/m03/shopping_list.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  Database? _database;
  final String _table_name = 'shopping_list';
  final String _db_name = 'shoppinglist_database.db';
  final int _db_version = 1;

  DBHelper() {
    _openDB();
  }

  Future<void> _openDB() async {
    _database ??= await openDatabase(
      join(await getDatabasesPath(), _db_name),
      onCreate: (db, version) {
        return db
            .execute('CREATE TABLE $_table_name (id INTEGER PRIMARY KEY, name TEXT, sum INTEGER)');
      },
      version: _db_version,
    );
  }

  Future<void> closeDB() async {
    await _database?.close();
    print('Database closed');
  }

  Future<void> insertShoppingList(ShoppingList temp) async {
    await _database?.insert(
      _table_name,
      temp.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteShoppingList(int id) async {
    await _database?.delete(
      _table_name,
      where: 'id = ?',
      whereArgs: [id],
    );
    print(DateTime.now());
  }

  Future<void> deleteAllShoppingList() async {
    await _database?.delete(_table_name);
  }

  Future<List<ShoppingList>> getShoppingList() async {
    if (_database != null) {
      final List<Map<String, dynamic>> maps = await _database!.query(_table_name);
      print(maps);

      return List.generate(
          maps.length,
          (index) => ShoppingList(
                maps[index]['id'],
                maps[index]['name'],
                maps[index]['sum'],
              ));
    }
    return [];
  }
}
