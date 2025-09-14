import 'package:color_generate/domain/entities/color_info.dart';

/// Abstract interface for color history data operations.
abstract interface class ColorHistoryRepository {
  /// Retrieves the last 5 colors from history.
  ///
  /// Returns a [Future] that completes with a list of [ColorInfo] objects,
  /// ordered by most recent first.
  Future<List<ColorInfo>> getLastColors();

  /// Saves a color to history.
  ///
  /// Takes a [ColorInfo] object and saves it to the history. If there are
  /// already 5 colors in history, the oldest one will be removed.
  ///
  /// Returns a [Future] that completes when the operation is done.
  Future<void> saveColor(ColorInfo color);
}
