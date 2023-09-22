import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  factory DatabaseHelper() {
    return instance;
  }

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    _database ??= await openDatabase(
        'my_database.db',
        version: 1,
        onCreate: (db, version) {
          db.execute('''
            CREATE TABLE users (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              first_name TEXT NOT NULL,
              last_name TEXT NOT NULL,
              email TEXT NOT NULL,
              date_of_birth TEXT NOT NULL,
              password TEXT NOT NULL
            )
          ''');
        },
      );

    return _database!;
  }

  // Insert a new user into the database
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;

    return await db.insert('users', user);
  }

  // Get all users from the database
  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;

    final results = await db.query('users');

    return results.map((result) => result).toList();
  }
}