import 'package:color_generate/core/database/database_provider.dart';
import 'package:color_generate/core/di/injection_container.dart';
import 'package:color_generate/data/datasources/color_history_data_source.dart';
import 'package:color_generate/data/repositories/color_repository_impl.dart';
import 'package:color_generate/domain/repositories/color_history_repository.dart';
import 'package:color_generate/domain/usecases/color_saver.dart';
import 'package:color_generate/domain/usecases/last_colors_getter.dart';
import 'package:color_generate/domain/usecases/random_color_generator.dart';
import 'package:color_generate/presentation/bloc/color_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    await sl.reset();
    await initializeDependencies();
  });

  test('should register DatabaseProvider as singleton', () {
    // Act
    final instance1 = sl<DatabaseProvider>();
    final instance2 = sl<DatabaseProvider>();

    // Assert
    expect(instance1, same(instance2));
  });

  test('should register ColorHistoryDataSource as lazy singleton', () {
    // Act
    final instance1 = sl<ColorHistoryDataSource>();
    final instance2 = sl<ColorHistoryDataSource>();

    // Assert
    expect(instance1, same(instance2));
  });

  test('should register repositories', () {
    // Assert
    expect(sl<ColorRepositoryImpl>(), isNotNull);
    expect(sl<ColorHistoryRepository>(), isNotNull);
  });

  test('should register use cases', () {
    // Assert
    expect(sl<GenerateRandomColorUseCase>(), isNotNull);
    expect(sl<SaveColorUseCase>(), isNotNull);
    expect(sl<GetLastColorsUseCase>(), isNotNull);
  });

  test('should register ColorBloc as factory', () {
    // Act
    final instance1 = sl<ColorBloc>();
    final instance2 = sl<ColorBloc>();

    // Assert
    expect(instance1, isNot(same(instance2)));
  });
}
