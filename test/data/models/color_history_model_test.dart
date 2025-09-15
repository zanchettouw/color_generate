import 'package:color_generate/data/models/color_history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final testDate = DateTime(2023);
  final testModel = ColorHistoryModel(
    id: 1,
    red: 255,
    green: 128,
    blue: 64,
    timestamp: testDate,
  );

  const maxRgbValue = 255;

  group('ColorHistoryModel', () {
    test('should create model with correct values', () {
      expect(testModel.id, equals(1));
      expect(testModel.red, equals(255));
      expect(testModel.green, equals(128));
      expect(testModel.blue, equals(64));
      expect(testModel.timestamp, equals(testDate));
    });

    test('should convert to map correctly', () {
      // Act
      final map = testModel.toMap();

      // Assert
      expect(map['id'], equals(1));
      expect(map['red'], equals(255));
      expect(map['green'], equals(128));
      expect(map['blue'], equals(64));
      expect(map['timestamp'], equals(testDate.millisecondsSinceEpoch));
    });

    test('should create from map correctly', () {
      // Arrange
      final map = {
        'id': 1,
        'red': 255,
        'green': 128,
        'blue': 64,
        'timestamp': testDate.millisecondsSinceEpoch,
      };

      // Act
      final model = ColorHistoryModel.fromMap(map);

      // Assert
      expect(model, equals(testModel));
    });

    test('should convert to Color correctly', () {
      // Act
      final color = testModel.toColor();

      // Assert
      expect(color.r * maxRgbValue, equals(255));
      expect(color.g * maxRgbValue, equals(128));
      expect(color.b * maxRgbValue, equals(64));
      expect(color.a * maxRgbValue, equals(255)); // Fully opaque
    });

    test('should create from Color correctly', () {
      // Arrange
      const color = Color.fromRGBO(255, 128, 64, 1);

      // Act
      final model = ColorHistoryModel.fromColor(color);

      // Assert
      expect(model.red, equals(255));
      expect(model.green, equals(128));
      expect(model.blue, equals(64));
      // We can't test the exact timestamp since it uses DateTime.now()
      expect(model.timestamp, isNotNull);
    });

    test('should implement value equality', () {
      // Arrange
      final model1 = ColorHistoryModel(
        id: 1,
        red: 255,
        green: 128,
        blue: 64,
        timestamp: testDate,
      );

      final model2 = ColorHistoryModel(
        id: 1,
        red: 255,
        green: 128,
        blue: 64,
        timestamp: testDate,
      );

      // Assert
      expect(model1, equals(model2));
    });
  });
}
