import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Data model representing a color entry in the database.
class ColorHistoryModel extends Equatable {
  /// Unique identifier for the color entry
  final int? id;

  /// Red component value (0-255)
  final int red;

  /// Green component value (0-255)
  final int green;

  /// Blue component value (0-255)
  final int blue;

  /// Timestamp when the color was saved
  final DateTime timestamp;

  /// Creates a new [ColorHistoryModel] instance.
  const ColorHistoryModel({
    required this.red,
    required this.green,
    required this.blue,
    required this.timestamp,
    this.id,
  });

  /// Creates a [ColorHistoryModel] from a database map.
  factory ColorHistoryModel.fromMap(Map<String, dynamic> map) {
    return ColorHistoryModel(
      id: map['id'] as int?,
      red: map['red'] as int,
      green: map['green'] as int,
      blue: map['blue'] as int,
      timestamp: DateTime.fromMillisecondsSinceEpoch(map['timestamp'] as int),
    );
  }

  /// Converts this model to a map for database storage.
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'red': red,
      'green': green,
      'blue': blue,
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  /// Converts this model to a [Color] object.
  Color toColor() => Color.fromRGBO(red, green, blue, 1);

  /// Creates a [ColorHistoryModel] from a [Color] object.
  factory ColorHistoryModel.fromColor(Color color) {
    return ColorHistoryModel(
      red: (color.r * 255).round(),
      green: (color.g * 255).round(),
      blue: (color.b * 255).round(),
      timestamp: DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [id, red, green, blue, timestamp];
}
