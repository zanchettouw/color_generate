import 'package:flutter/material.dart';

import 'package:color_generate/domain/entities/color_info.dart';

/// A widget that displays a list of previously used colors.
class ColorHistoryList extends StatelessWidget {
  /// The list of colors to display.
  final List<ColorInfo> colors;

  /// Callback function when a color is selected.
  final ValueChanged<ColorInfo> onColorSelected;

  /// Creates a new [ColorHistoryList] instance.
  const ColorHistoryList({
    required this.colors,
    required this.onColorSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) {
          final color = colors[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => onColorSelected(color),
              child: Container(
                width: 50,
                decoration: BoxDecoration(
                  color: color.color,
                  border: Border.all(color: Colors.white, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
