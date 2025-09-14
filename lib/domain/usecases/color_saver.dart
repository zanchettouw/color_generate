import 'package:color_generate/domain/entities/color_info.dart';
import 'package:color_generate/domain/repositories/color_history_repository.dart';

/// Use case for saving a color to history.
class SaveColorUseCase {
  final ColorHistoryRepository _repository;

  /// Creates a new [SaveColorUseCase] instance.
  const SaveColorUseCase(this._repository);

  /// Executes the use case.
  ///
  /// Takes a [ColorInfo] and saves it to history. If there are already 5 colors
  /// in history, the oldest one will be removed.
  ///
  /// Returns a [Future] that completes when the operation is done.
  Future<void> call(ColorInfo color) => _repository.saveColor(color);
}
