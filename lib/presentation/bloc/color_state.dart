import 'package:equatable/equatable.dart';

import 'package:color_generate/domain/entities/color_info.dart';

/// Base class for all color-related states in the application.
///
/// This abstract class extends [Equatable] to provide value equality
/// comparison for states. All color states should extend this class
/// and implement the [props] getter to ensure proper state comparison.
abstract class ColorState extends Equatable {
  /// Creates a new [ColorState] instance.
  const ColorState();

  @override
  List<Object?> get props => [];
}

/// Base class for states that contain color information.
abstract class ColorWithHistoryState extends ColorState {
  /// The current color information.
  final ColorInfo colorInfo;

  /// The list of previous colors.
  /// Can be null if history hasn't been loaded yet.
  final List<ColorInfo>? colorHistory;

  /// Creates a new [ColorWithHistoryState] instance.
  const ColorWithHistoryState({required this.colorInfo, this.colorHistory});

  @override
  List<Object?> get props => [colorInfo, colorHistory];
}

/// Represents the initial state of the color feature.
///
/// This state is used when the application first starts and contains
/// the initial color information and empty history.
class ColorInitial extends ColorWithHistoryState {
  /// Creates a new [ColorInitial] state.
  const ColorInitial({required super.colorInfo, super.colorHistory});
}

/// Represents the state after a color has been updated.
///
/// This state is emitted whenever a new color is set, either through
/// random generation or history selection.
class ColorUpdated extends ColorWithHistoryState {
  /// Creates a new [ColorUpdated] state.
  const ColorUpdated({required super.colorInfo, super.colorHistory});
}

/// Represents an error state in the color feature.
class ColorError extends ColorState {
  /// The error message.
  final String message;

  /// Creates a new [ColorError] state.
  const ColorError(this.message);

  @override
  List<Object?> get props => [message];
}
