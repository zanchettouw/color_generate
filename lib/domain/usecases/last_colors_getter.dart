import 'package:color_generate/domain/entities/color_info.dart';
import 'package:color_generate/domain/repositories/color_history_repository.dart';

/// Use case for retrieving the last 5 colors from history.
class GetLastColorsUseCase {
  final ColorHistoryRepository _repository;

  /// Creates a new [GetLastColorsUseCase] instance.
  const GetLastColorsUseCase(this._repository);

  /// Executes the use case.
  ///
  /// Returns a [Future] that completes with a list of [ColorInfo] objects,
  /// ordered by most recent first.
  Future<List<ColorInfo>> call() => _repository.getLastColors();
}
