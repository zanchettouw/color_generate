import 'package:color_generate/data/datasources/color_history_data_source.dart';
import 'package:color_generate/data/models/color_history_model.dart';
import 'package:color_generate/data/repositories/impl/color_history_repository_impl.dart';
import 'package:color_generate/domain/entities/color_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([ColorHistoryDataSource])
import 'color_history_repository_impl_test.mocks.dart';

void main() {
  late ColorHistoryRepositoryImpl sut;
  late MockColorHistoryDataSource mockDataSource;
  const maxRgbValue = 255;

  setUp(() {
    mockDataSource = MockColorHistoryDataSource();
    sut = ColorHistoryRepositoryImpl(dataSource: mockDataSource);
  });

  group('getLastColors', () {
    test('should return list of ColorInfo from data source', () async {
      // Arrange
      final testModel = ColorHistoryModel(
        red: 255,
        green: 128,
        blue: 64,
        timestamp: DateTime.now(),
      );
      when(mockDataSource.getLastColors()).thenAnswer((_) async => [testModel]);

      // Act
      final result = await sut.getLastColors();

      // Assert
      expect(result.length, equals(1));
      expect(result.first.color.r * maxRgbValue, equals(255));
      expect(result.first.color.g * maxRgbValue, equals(128));
      expect(result.first.color.b * maxRgbValue, equals(64));
    });

    test('should return empty list when data source returns empty', () async {
      // Arrange
      when(mockDataSource.getLastColors()).thenAnswer((_) async => []);

      // Act
      final result = await sut.getLastColors();

      // Assert
      expect(result, isEmpty);
    });
  });

  group('saveColor', () {
    test('should convert ColorInfo to ColorHistoryModel and save', () async {
      // Arrange
      const colorInfo = ColorInfo(color: Color.fromRGBO(255, 128, 64, 1));

      // Act
      await sut.saveColor(colorInfo);

      // Assert
      final captured =
          verify(mockDataSource.saveColor(captureAny)).captured.single
              as ColorHistoryModel;
      expect(captured.red, equals(255));
      expect(captured.green, equals(128));
      expect(captured.blue, equals(64));
    });
  });
}
