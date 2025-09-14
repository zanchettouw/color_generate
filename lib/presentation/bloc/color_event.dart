import 'package:equatable/equatable.dart';

import 'package:color_generate/domain/entities/color_info.dart';

/// Base class for all color-related events in the application.
///
/// This abstract class extends [Equatable] to provide value equality
/// comparison for events. All color events should extend this class
/// to ensure consistent handling in the BLoC pattern.
abstract class ColorEvent extends Equatable {
  /// Creates a new [ColorEvent] instance.
  ///
  /// This constructor is const to allow for event instances to be constant.
  const ColorEvent();

  @override
  List<Object?> get props => [];
}

/// Event that triggers the generation of a new random color.
///
/// This event is dispatched when the user taps on the screen and expects
/// a new random color to be generated and displayed.
///
/// Example usage:
/// ```dart
/// colorBloc.add(const GenerateRandomColorEvent());
/// ```
class GenerateRandomColorEvent extends ColorEvent {
  /// Creates a new [GenerateRandomColorEvent] instance.
  ///
  /// This event doesn't require any parameters as it simply triggers
  /// the generation of a new random color.
  const GenerateRandomColorEvent();
}

/// Event that triggers setting a specific color from history.
///
/// This event is dispatched when the user
/// selects a color from the history list.
class SetColorFromHistoryEvent extends ColorEvent {
  /// The color to set from history.
  final ColorInfo colorInfo;

  /// Creates a new [SetColorFromHistoryEvent] instance.
  const SetColorFromHistoryEvent(this.colorInfo);

  @override
  List<Object?> get props => [colorInfo];
}

/// Event that loads the color history.
///
/// This event is dispatched when the application starts or when the history
/// needs to be refreshed.
class LoadColorHistoryEvent extends ColorEvent {
  /// Creates a new [LoadColorHistoryEvent] instance.
  const LoadColorHistoryEvent();
}
