import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Database provider for the application.
///
/// This class follows the Singleton pattern to ensure only one database
/// connection is maintained throughout the application lifecycle.
class DatabaseProvider {
  static const String _databaseName = 'color_changer.db';
  static const int _databaseVersion = 1;

  static Database? _database;
  static final DatabaseProvider _instance = DatabaseProvider._internal();

  /// Gets the database instance, creating it if necessary.
  ///
  /// Returns a [Future] that resolves to the database instance.
  Future<Database> get database async {
    _database ??= await _initDatabase();

    return _database ?? await _initDatabase();
  }

  /// Factory constructor to return the singleton instance
  factory DatabaseProvider() => _instance;

  /// Private constructor for singleton pattern
  DatabaseProvider._internal();

  Future<Database> _initDatabase() async {
    // Initialize FFI for desktop/non-mobile platforms
    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      sqfliteFfiInit();
      // Change the default factory for unit tests
      databaseFactory = databaseFactoryFfi;
    }

    final dbPath = await getDatabasesPath();
    final pathToDb = path.join(dbPath, _databaseName);

    return openDatabase(
      pathToDb,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int _) async {
    await db.execute('''
      CREATE TABLE color_history (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        red INTEGER NOT NULL,
        green INTEGER NOT NULL,
        blue INTEGER NOT NULL,
        timestamp INTEGER NOT NULL
      )
    ''');
  }
}
