import 'package:color_generate/domain/entities/color_info.dart';
import 'package:color_generate/domain/repositories/color_repository.dart';

/// Use case for generating random colors
class GenerateRandomColorUseCase {
  final ColorRepository _repository;

  /// Creates a new GenerateRandomColorUseCase instance
  const GenerateRandomColorUseCase(this._repository);

  /// Generate a random color
  ColorInfo call() => _repository.generateRandomColor();
}
