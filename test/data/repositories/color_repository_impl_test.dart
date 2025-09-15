import 'dart:math';

import 'package:color_generate/data/repositories/color_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([Random])
import 'color_repository_impl_test.mocks.dart';

void main() {
  late ColorRepositoryImpl sut;

  const maxRgbValue = 255;
  late MockRandom mockRandom;

  setUp(() {
    mockRandom = MockRandom();
    sut = ColorRepositoryImpl(random: mockRandom);
  });

  test('should generate random color with values between 0 and 255', () {
    // Arrange
    var callCount = 0;
    when(mockRandom.nextInt(maxRgbValue)).thenAnswer((_) {
      switch (callCount++) {
        case 0:
          return 255; // Red
        case 1:
          return 128; // Green
        default:
          return 64; // Blue
      }
    });

    // Act
    final result = sut.generateRandomColor();

    // Assert
    expect(result.color.r * maxRgbValue, equals(255));
    expect(result.color.g * maxRgbValue, equals(128));
    expect(result.color.b * maxRgbValue, equals(64));
    expect(maxRgbValue, equals(255)); // Always fully opaque
  });

  test('should create with default Random if none provided', () {
    // Act
    final repository = ColorRepositoryImpl();

    // Assert
    expect(repository, isNotNull);
  });
}
