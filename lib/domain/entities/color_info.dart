import 'package:flutter/material.dart';

/// Entity that represents color information and provides utility methods
/// for handling color-related operations.
///
/// This entity encapsulates a [Color] and provides methods to:
/// - Get a string representation of RGB values
/// - Determine appropriate text color based on background luminance
class ColorInfo {
  /// The RGB color value.
  ///
  /// This color can be used directly in Flutter widgets and contains
  /// information about red, green, and blue channels.
  final Color color;

  /// Creates a new [ColorInfo] instance with the specified [color].
  ///
  /// The [color] parameter must not be null as it's required for all
  /// color-related operations.
  const ColorInfo({required this.color});

  /// Returns a string representation of the RGB values.
  ///
  /// Format: "RGB: (red, green, blue)" where each value is between 0 and 255.
  /// Example: "RGB: (255, 128, 0)" for an orange color.
  String get rgbString {
    final r = (color.r * 255).round();
    final g = (color.g * 255).round();
    final b = (color.b * 255).round();

    return 'RGB: ($r, $g, $b)';
  }

  /// Determines if text should be dark based on background luminance.
  ///
  /// Returns true if the background is light enough to use dark text,
  /// false if the background is dark and should use light text.
  /// This is calculated using the color's luminance value with a threshold of 0.5.
  bool get shouldUseDarkText => color.computeLuminance() > 0.5;
}
