import 'package:color_generate/data/models/color_history_model.dart';

/// Abstract interface for color history data source operations.
abstract interface class ColorHistoryDataSource {
  /// Retrieves the last 5 colors from the database.
  ///
  /// Returns a [Future] that completes with a list of [ColorHistoryModel] objects,
  /// ordered by most recent first.
  Future<List<ColorHistoryModel>> getLastColors();

  /// Saves a color to the database.
  ///
  /// Takes a [ColorHistoryModel] and saves it to the database. If there are
  /// already 5 colors in the database, the oldest one will be removed.
  ///
  /// Returns a [Future] that completes when the operation is done.
  Future<void> saveColor(ColorHistoryModel color);
}
