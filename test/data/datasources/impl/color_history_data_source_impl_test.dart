import 'package:color_generate/core/database/database_provider.dart';
import 'package:color_generate/data/datasources/impl/color_history_data_source_impl.dart';
import 'package:color_generate/data/models/color_history_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';

//ignore_for_file: avoid_late_keyword

@GenerateNiceMocks([
  MockSpec<DatabaseProvider>(),
  MockSpec<Database>(),
  MockSpec<Transaction>(),
])
import 'color_history_data_source_impl_test.mocks.dart';

// Test constants
const testId = 1;
const testRed = 255;
const testGreen = 128;
const testBlue = 64;
const maxHistoryCount = 5;
const belowLimitCount = 3;

void main() {
  late ColorHistoryDataSourceImpl sut;
  late MockDatabaseProvider mockDatabaseProvider;
  late MockDatabase mockDatabase;
  late MockTransaction mockTransaction;

  setUp(() {
    mockDatabaseProvider = MockDatabaseProvider();
    mockDatabase = MockDatabase();
    mockTransaction = MockTransaction();
    sut = ColorHistoryDataSourceImpl(databaseProvider: mockDatabaseProvider);

    when(mockDatabaseProvider.database).thenAnswer((_) async => mockDatabase);
  });

  group('getLastColors', () {
    test('should return list of ColorHistoryModel from database', () async {
      // Arrange
      final testDate = DateTime(2023);
      // Test constants
      const testId = 1;
      const testRed = 255;
      const testGreen = 128;
      const testBlue = 64;

      final testData = [
        {
          'id': testId,
          'red': testRed,
          'green': testGreen,
          'blue': testBlue,
          'timestamp': testDate.millisecondsSinceEpoch,
        },
      ];

      when(
        mockDatabase.query(
          'color_history',
          orderBy: anyNamed('orderBy'),
          limit: anyNamed('limit'),
        ),
      ).thenAnswer((_) async => testData);

      // Act
      final result = await sut.getLastColors();

      // Assert
      expect(result.length, equals(1));
      expect(result.first.id, equals(1));
      expect(result.first.red, equals(255));
      expect(result.first.green, equals(128));
      expect(result.first.blue, equals(64));
      expect(result.first.timestamp, equals(testDate));
    });
  });

  group('saveColor', () {
    test('should delete oldest color when limit is reached', () async {
      // Arrange
      final testModel = ColorHistoryModel(
        red: 255,
        green: 128,
        blue: 64,
        timestamp: DateTime(2023),
      );

      // Set up transaction mock to return void
      when(mockDatabase.transaction(any)).thenAnswer((inv) async {
        // ignore: avoid_dynamic_calls
        await inv.positionalArguments[0](mockTransaction);
      });

      // Set up mock responses
      when(mockTransaction.rawQuery(any)).thenAnswer(
        (_) async => [
          {'COUNT(*)': 5},
        ],
      );

      when(
        mockTransaction.delete(
          any,
          where: anyNamed('where'),
          whereArgs: anyNamed('whereArgs'),
        ),
      ).thenAnswer((_) async => 1);

      when(mockTransaction.insert(any, any)).thenAnswer((_) async => 1);

      // Act
      await sut.saveColor(testModel);

      // Assert
      verify(
        mockTransaction.delete(
          'color_history',
          where: '''
              id IN 
                (SELECT id FROM color_history ORDER BY timestamp ASC LIMIT 1)
        ''',
        ),
      ).called(1);

      verify(
        mockTransaction.insert('color_history', testModel.toMap()),
      ).called(1);
    });

    test('should only insert when limit not reached', () async {
      // Arrange
      final testModel = ColorHistoryModel(
        red: 255,
        green: 128,
        blue: 64,
        timestamp: DateTime(2023),
      );

      // Set up transaction mock to return void
      when(mockDatabase.transaction(any)).thenAnswer((inv) async {
        // ignore: avoid_dynamic_calls
        await inv.positionalArguments[0](mockTransaction);
      });

      // Set up mock responses
      when(mockTransaction.rawQuery(any)).thenAnswer(
        (_) async => [
          {'COUNT(*)': 3},
        ],
      );

      when(mockTransaction.insert(any, any)).thenAnswer((_) async => 1);

      // Act
      await sut.saveColor(testModel);

      // Assert
      verifyNever(
        mockTransaction.delete('color_history', where: anyNamed('where')),
      );

      verify(
        mockTransaction.insert('color_history', testModel.toMap()),
      ).called(1);
    });
  });
}
