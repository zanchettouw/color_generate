import 'package:color_generate/core/database/database_provider.dart';
import 'package:color_generate/data/datasources/color_history_data_source.dart';
import 'package:color_generate/data/models/color_history_model.dart';
import 'package:sqflite/sqflite.dart';

/// SQLite implementation of [ColorHistoryDataSource].
class ColorHistoryDataSourceImpl implements ColorHistoryDataSource {
  final DatabaseProvider _databaseProvider;

  /// Creates a new [ColorHistoryDataSourceImpl] instance.
  ColorHistoryDataSourceImpl({required DatabaseProvider databaseProvider})
    : _databaseProvider = databaseProvider;

  @override
  Future<List<ColorHistoryModel>> getLastColors() async {
    final db = await _databaseProvider.database;
    final results = await db.query(
      'color_history',
      orderBy: 'timestamp DESC',
      limit: 5,
    );

    return results.map(ColorHistoryModel.fromMap).toList();
  }

  @override
  Future<void> saveColor(ColorHistoryModel color) async {
    final db = await _databaseProvider.database;

    await db.transaction((txn) async {
      // Get current count
      final count = Sqflite.firstIntValue(
        await txn.rawQuery('SELECT COUNT(*) FROM color_history'),
      );

      // If we already have 5 colors, delete the oldest one
      if (count != null && count >= 5) {
        await txn.delete(
          'color_history',
          where: '''
              id IN 
                (SELECT id FROM color_history ORDER BY timestamp ASC LIMIT 1)
        ''',
        );
      }

      // Insert the new color
      await txn.insert('color_history', color.toMap());
    });
  }
}
