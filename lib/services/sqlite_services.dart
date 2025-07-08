import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/item_model.dart';

class DBService {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'items.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE items(
          id INTEGER PRIMARY KEY,
          title TEXT,
          body TEXT
        )
      ''');
    });
  }

  static Future<void> insertItems(List<Item> items) async {
    final db = await database;
    Batch batch = db.batch();
    for (var item in items) {
      batch.insert(
        'items',
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  static Future<List<Item>> getPosts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('posts');
    print('Fetched from db: ${maps.length} items');
    return maps.map((map) => Item.fromJson(map)).toList();
  }


  static Future<void> clearPosts() async {
    final db = await database;
    await db.delete('posts');
  }
}
