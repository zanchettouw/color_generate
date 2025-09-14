import 'dart:math';

import 'package:color_generate/domain/entities/color_info.dart';
import 'package:color_generate/domain/repositories/color_repository.dart';
import 'package:flutter/material.dart';

/// A concrete implementation of [ColorRepository] that generates random colors.
///
/// This implementation uses Dart's [Random] class to generate random RGB values
/// for creating colors. It ensures that:
/// - Each color component (R, G, B) is between 0 and 255
/// - Colors are always fully opaque (alpha = 1.0)
/// - The distribution of colors is uniform across the RGB color space
class ColorRepositoryImpl implements ColorRepository {
  /// Maximum value for RGB components (0-255 inclusive)
  static const int _maxRgbValue = 255;

  /// The random number generator used for color generation.
  ///
  /// This can be injected for testing purposes to make the color
  /// generation deterministic.
  final Random _random;

  /// Creates a new [ColorRepositoryImpl] instance.
  ///
  /// The [random] parameter is optional and allows injecting a custom
  /// random number generator. If not provided, a new [Random] instance
  /// will be created.
  ///
  /// This is particularly useful for testing where you might want to
  /// provide a seeded random number generator for predictable results.
  ColorRepositoryImpl({Random? random}) : _random = random ?? Random();

  @override
  ColorInfo generateRandomColor() {
    return ColorInfo(
      color: Color.fromRGBO(
        _random.nextInt(_maxRgbValue), // Red component (0-255)
        _random.nextInt(_maxRgbValue), // Green component (0-255)
        _random.nextInt(_maxRgbValue), // Blue component (0-255)
        1, // Alpha component (fully opaque)
      ),
    );
  }
}
