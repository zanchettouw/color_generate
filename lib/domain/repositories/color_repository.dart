import 'package:color_generate/domain/entities/color_info.dart';

/// Repository interface for color generation operations.
///
/// This abstract class defines the contract for color-related operations
/// in the application. It follows the Repository pattern to abstract
/// the color generation logic from the rest of the application.
///
/// Implementations of this interface should provide concrete implementations
/// for generating random colors with specific constraints or rules.
abstract class ColorRepository {
  /// Generates a random color with RGB values.
  ///
  /// Returns a [ColorInfo] instance containing the generated color.
  /// Each RGB component should be in the range of 0-255, allowing for
  /// 16,777,216 (256^3) possible color combinations.
  ///
  /// The generated color should be suitable for use as a background color,
  /// meaning it should be fully opaque (alpha = 1.0).
  ColorInfo generateRandomColor();
}
