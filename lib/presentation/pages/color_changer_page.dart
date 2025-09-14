import 'package:color_generate/domain/entities/color_info.dart';
import 'package:color_generate/presentation/bloc/color_bloc.dart';
import 'package:color_generate/presentation/bloc/color_event.dart';
import 'package:color_generate/presentation/bloc/color_state.dart';
import 'package:color_generate/presentation/widgets/adaptive_text.dart';
import 'package:color_generate/presentation/widgets/color_history_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// The main page of the application that displays a color-changing background.
///
/// This page shows:
/// - A "Hello there" message in the center
/// - The current RGB values of the background color
/// - Changes background color when tapped anywhere on the screen
///
/// The page uses [BlocBuilder] to rebuild when the color state changes and
/// [AdaptiveText] to ensure text is readable on any background color.
class ColorChangerPage extends StatelessWidget {
  /// Creates a new [ColorChangerPage] instance.
  ///
  /// This widget expects a [ColorBloc] to be provided in the widget tree
  /// above it using [BlocProvider].
  const ColorChangerPage({super.key});

  /// Handles tap events on the page.
  ///
  /// When the page is tapped, this method
  /// dispatches a [GenerateRandomColorEvent]
  /// to the [ColorBloc] to request a new random background color.
  ///
  /// The [context] parameter is used to access the [ColorBloc] instance.
  void _onTap(BuildContext context) {
    context.read<ColorBloc>().add(const GenerateRandomColorEvent());
  }

  void _onColorSelected(BuildContext context, ColorInfo colorInfo) {
    context.read<ColorBloc>().add(SetColorFromHistoryEvent(colorInfo));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorBloc, ColorState>(
      builder: (context, state) {
        if (state is ColorError) {
          return Scaffold(
            body: Center(
              child: Text(
                'Error: ${state.message}',
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        if (state is! ColorWithHistoryState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return GestureDetector(
          onTapDown: (_) => _onTap(context),
          child: Scaffold(
            backgroundColor: state.colorInfo.color,
            body: Stack(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hello there',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AdaptiveText(
                        text: state.colorInfo.rgbString,
                        style: const TextStyle(fontSize: 16),
                        useDarkText: state.colorInfo.shouldUseDarkText,
                      ),
                    ],
                  ),
                ),
                if (state.colorHistory?.isNotEmpty ?? false) ...[
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 32,
                    child: ColorHistoryList(
                      colors: state.colorHistory ?? [],
                      onColorSelected: (color) {
                        _onColorSelected(context, color);
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
