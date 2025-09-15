import 'package:color_generate/core/database/database_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late DatabaseProvider sut;

  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() {
    sut = DatabaseProvider();
  });

  test('should be a singleton', () {
    // Arrange
    final instance1 = DatabaseProvider();
    final instance2 = DatabaseProvider();

    // Assert
    expect(instance1, same(instance2));
  });

  group('database initialization', () {
    test('should create database on first access', () async {
      // Act
      final db = await sut.database;

      // Assert
      expect(db, isNotNull);
      expect(db.path.contains('color_changer.db'), isTrue);
    });

    test('should return same database instance on subsequent calls', () async {
      // Act
      final db1 = await sut.database;
      final db2 = await sut.database;

      // Assert
      expect(db1, same(db2));
    });

    test('should create color_history table', () async {
      // Act
      final db = await sut.database;

      // Assert
      final tables = await db.query(
        'sqlite_master',
        where: 'type = ? AND name = ?',
        whereArgs: ['table', 'color_history'],
      );

      expect(tables, hasLength(1));

      final tableInfo = await db.query(
        'pragma_table_info(?)',
        whereArgs: ['color_history'],
      );

      expect(tableInfo, hasLength(5)); // id, red, green, blue, timestamp
      expect(
        tableInfo.map((c) => c['name']),
        containsAll(['id', 'red', 'green', 'blue', 'timestamp']),
      );
    });
  });
}
