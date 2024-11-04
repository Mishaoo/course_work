import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/user.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT NOT NULL,
      password TEXT NOT NULL
    );
    ''');
  }

  // Функція для реєстрації користувача
  Future<int?> registerUser(User user) async {
    final db = await instance.database;

    // Перевірка, чи існує користувач
    var existingUser = await db.query('users',
        where: 'username = ?', whereArgs: [user.username]);
    if (existingUser.isNotEmpty) {
      return -1; // Код для "користувач уже існує"
    }

    // Додаємо користувача, якщо він не існує
    return await db.insert('users', user.toMap());
  }

  // Функція для входу користувача
  Future<User?> loginUser(String username, String password) async {
    final db = await instance.database;
    var users = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    if (users.isNotEmpty) {
      return User.fromMap(users.first);
    }
    return null;
  }
}
