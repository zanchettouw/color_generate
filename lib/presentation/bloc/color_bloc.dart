import 'package:color_generate/domain/usecases/color_saver.dart';
import 'package:color_generate/domain/usecases/last_colors_getter.dart';
import 'package:color_generate/domain/usecases/random_color_generator.dart';
import 'package:color_generate/presentation/bloc/color_event.dart';
import 'package:color_generate/presentation/bloc/color_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BLoC for managing color state and history.
class ColorBloc extends Bloc<ColorEvent, ColorState> {
  final GenerateRandomColorUseCase _generateRandomColor;
  final SaveColorUseCase _saveColor;
  final GetLastColorsUseCase _getLastColors;

  /// Creates a new [ColorBloc] instance.
  ColorBloc({
    required GenerateRandomColorUseCase generateRandomColor,
    required SaveColorUseCase saveColor,
    required GetLastColorsUseCase getLastColors,
  }) : _generateRandomColor = generateRandomColor,
       _saveColor = saveColor,
       _getLastColors = getLastColors,
       super(ColorInitial(colorInfo: generateRandomColor())) {
    on<GenerateRandomColorEvent>(_onGenerateRandomColor);
    on<SetColorFromHistoryEvent>(_onSetColorFromHistory);
    on<LoadColorHistoryEvent>(_onLoadColorHistory);
  }

  Future<void> _onGenerateRandomColor(
    GenerateRandomColorEvent event,
    Emitter<ColorState> emit,
  ) async {
    try {
      // First get the history (which will be shown)
      final history = await _getLastColors();

      // Generate and save the new color
      final colorInfo = _generateRandomColor();
      await _saveColor(colorInfo);

      // History shows the previous colors, not including the current one
      emit(ColorUpdated(colorInfo: colorInfo, colorHistory: history));
    } catch (e) {
      emit(ColorError('Failed to generate color: $e'));
    }
  }

  Future<void> _onSetColorFromHistory(
    SetColorFromHistoryEvent event,
    Emitter<ColorState> emit,
  ) async {
    try {
      // Save the selected color from history as the current color
      await _saveColor(event.colorInfo);

      // Get the updated history (excluding the now-current color)
      final history = await _getLastColors();

      emit(ColorUpdated(colorInfo: event.colorInfo, colorHistory: history));
    } catch (e) {
      emit(ColorError('Failed to set color from history: $e'));
    }
  }

  Future<void> _onLoadColorHistory(
    LoadColorHistoryEvent event,
    Emitter<ColorState> emit,
  ) async {
    try {
      if (state is ColorWithHistoryState) {
        final currentState = state as ColorWithHistoryState;
        final history = await _getLastColors();

        emit(
          ColorUpdated(
            colorInfo: currentState.colorInfo,
            colorHistory: history,
          ),
        );
      }
    } catch (e) {
      emit(ColorError('Failed to load color history: $e'));
    }
  }
}
