import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {

  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("musicdp.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE online_sources(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      url TEXT UNIQUE,
      last_used TEXT
    )
    ''');
    await db.execute('''
      CREATE TABLE songs(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        url TEXT,
        artist TEXT,
        played_at TEXT
      )
    ''');
  }

  // Save streaming URL history
  Future<void> insertUrl(String url) async {
    final db = await instance.database;
    await db.insert(
      "online_sources",
      {
        "url": url,
        "last_used": DateTime.now().toString()
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get last 10 URLs
  Future<List<String>> getUrls() async {
    final db = await instance.database;
    final result = await db.query(
      "online_sources",
      orderBy: "last_used DESC",
      limit: 10,
    );
    return result.map((e) => e["url"].toString()).toList();
  }

  // Insert played song
  Future insertSong({
    required String title,
    required String url,
    String? artist,
  }) async {

    final db = await instance.database;
    return await db.insert(
      'songs',
      {
        "title": title,
        "url": url,
        "artist": artist,
        "played_at": DateTime.now().toString()
      },
    );
  }

  // Get recently played songs
  Future<List<Map<String, dynamic>>> getRecentSongs() async {
    final db = await instance.database;
    return await db.query(
      "songs",
      orderBy: "played_at DESC",
      limit: 20,
    );
  }

}