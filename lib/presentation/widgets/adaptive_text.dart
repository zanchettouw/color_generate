import 'package:flutter/material.dart';

/// A text widget that adapts its color based on the background color.
///
/// This widget automatically adjusts its text color between black and white
/// based on the provided [useDarkText] parameter, which should be determined
/// by the background color's luminance.
///
/// Example usage:
/// ```dart
/// AdaptiveText(
///   text: 'Hello World',
///   style: TextStyle(fontSize: 16),
///   useDarkText: backgroundColor.computeLuminance() > 0.5,
/// )
/// ```
class AdaptiveText extends StatelessWidget {
  /// The text to display.
  final String text;

  /// The base style for the text.
  ///
  /// This style will be modified to include the appropriate text color
  /// based on [useDarkText].
  final TextStyle style;

  /// Whether to use dark (black) text.
  ///
  /// If true, the text will be black; if false, the text will be white.
  /// This should be determined based on the background color's luminance
  /// for optimal readability.
  final bool useDarkText;

  /// Creates a new [AdaptiveText] instance.
  ///
  /// All parameters are required:
  /// - [text]: The string to display
  /// - [style]: The base text style (color will be overridden)
  /// - [useDarkText]: Whether to use dark text on light background
  const AdaptiveText({
    required this.text,
    required this.style,
    required this.useDarkText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style.copyWith(color: useDarkText ? Colors.black : Colors.white),
    );
  }
}
