import 'package:color_generate/data/models/color_history_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Test constants
const testId = 1;
const testRed = 255;
const testGreen = 128;
const testBlue = 64;
const maxRgbValue = 255;
const testOpacity = 1.0;

void main() {
  final testDate = DateTime(2023);
  final testModel = ColorHistoryModel(
    id: testId,
    red: testRed,
    green: testGreen,
    blue: testBlue,
    timestamp: testDate,
  );

  const maxRgbValue = 255;

  group('ColorHistoryModel', () {
    test('should create model with correct values', () {
      expect(testModel.id, equals(testId));
      expect(testModel.red, equals(testRed));
      expect(testModel.green, equals(testGreen));
      expect(testModel.blue, equals(testBlue));
      expect(testModel.timestamp, equals(testDate));
    });

    test('should convert to map correctly', () {
      // Act
      final map = testModel.toMap();

      // Assert
      expect(map['id'], equals(testId));
      expect(map['red'], equals(testRed));
      expect(map['green'], equals(testGreen));
      expect(map['blue'], equals(testBlue));
      expect(map['timestamp'], equals(testDate.millisecondsSinceEpoch));
    });

    test('should create from map correctly', () {
      // Arrange
      final map = {
        'id': testId,
        'red': testRed,
        'green': testGreen,
        'blue': testBlue,
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
      expect(color.r * maxRgbValue, equals(testRed));
      expect(color.g * maxRgbValue, equals(testGreen));
      expect(color.b * maxRgbValue, equals(testBlue));
      expect(color.a * maxRgbValue, equals(maxRgbValue)); // Fully opaque
    });

    test('should create from Color correctly', () {
      // Arrange
      const color = Color.fromRGBO(testRed, testGreen, testBlue, testOpacity);

      // Act
      final model = ColorHistoryModel.fromColor(color);

      // Assert
      expect(model.red, equals(testRed));
      expect(model.green, equals(testGreen));
      expect(model.blue, equals(testBlue));
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
