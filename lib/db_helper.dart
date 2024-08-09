import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper.internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper.internal();

  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    String path = join(await getDatabasesPath(), "login_demo.db");
    print("DatabaseHelper: Initializing database at path: $path");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int newVersion) async {
    print("DatabaseHelper: Creating user table");
    await db.execute(
        "CREATE TABLE user(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
  }

  Future<int> saveUser(String username, String password) async {
    var dbClient = await db;
    print("DatabaseHelper: Saving user: $username");
    return await dbClient
        .insert("user", {'username': username, 'password': password});
  }

  Future<Map<String, dynamic>?> getUser(
      String username, String password) async {
    var dbClient = await db;
    print("DatabaseHelper: Retrieving user: $username");
    List<Map<String, dynamic>> result = await dbClient.rawQuery(
        "SELECT * FROM user WHERE username = ? AND password = ?",
        [username, password]);
    if (result.isNotEmpty) {
      print("DatabaseHelper: User found");
      return result.first;
    }
    print("DatabaseHelper: User not found");
    return null;
  }
}
