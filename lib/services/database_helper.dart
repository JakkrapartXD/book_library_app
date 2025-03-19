import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/book.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('book_library.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE books (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        author TEXT NOT NULL,
        category TEXT NOT NULL,
        readingStatus TEXT NOT NULL,
        notes TEXT,
        dateAdded TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertBook(Book book) async {
    final db = await database;
    return await db.insert('books', book.toMap());
  }

  Future<int> updateBook(Book book) async {
    final db = await database;
    return await db.update(
      'books',
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> deleteBook(int id) async {
    final db = await database;
    return await db.delete('books', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Book>> getAllBooks() async {
    final db = await database;
    final result = await db.query('books', orderBy: 'dateAdded DESC');
    return result.map((map) => Book.fromMap(map)).toList();
  }

  Future<List<Book>> searchBooks(String query) async {
    final db = await database;
    final result = await db.query(
      'books',
      where: 'title LIKE ? OR author LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return result.map((map) => Book.fromMap(map)).toList();
  }

  Future<List<Book>> getBooksByCategory(String category) async {
    final db = await database;
    final result = await db.query(
      'books',
      where: 'category = ?',
      whereArgs: [category],
    );
    return result.map((map) => Book.fromMap(map)).toList();
  }

  Future<List<Book>> getBooksByStatus(String status) async {
    final db = await database;
    final result = await db.query(
      'books',
      where: 'readingStatus = ?',
      whereArgs: [status],
    );
    return result.map((map) => Book.fromMap(map)).toList();
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
