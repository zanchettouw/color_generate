import 'package:color_generate/core/database/database_provider.dart';
import 'package:color_generate/data/datasources/color_history_data_source.dart';
import 'package:color_generate/data/datasources/impl/color_history_data_source_impl.dart';
import 'package:color_generate/data/repositories/color_repository_impl.dart';
import 'package:color_generate/data/repositories/impl/color_history_repository_impl.dart';
import 'package:color_generate/domain/repositories/color_history_repository.dart';
import 'package:color_generate/domain/usecases/color_saver.dart';
import 'package:color_generate/domain/usecases/last_colors_getter.dart';
import 'package:color_generate/domain/usecases/random_color_generator.dart';
import 'package:color_generate/presentation/bloc/color_bloc.dart';
import 'package:get_it/get_it.dart';

/// Global service locator
final sl = GetIt.instance;

/// Initializes dependency injection
Future<void> initializeDependencies() async {
  // Database
  sl.registerSingleton<DatabaseProvider>(DatabaseProvider());
  await sl<DatabaseProvider>().database;

  // Data Sources
  sl.registerLazySingleton<ColorHistoryDataSource>(
    () => ColorHistoryDataSourceImpl(databaseProvider: sl()),
  );

  // Repositories
  sl.registerLazySingleton(ColorRepositoryImpl.new);
  sl.registerLazySingleton<ColorHistoryRepository>(
    () => ColorHistoryRepositoryImpl(dataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(
    () => GenerateRandomColorUseCase(sl<ColorRepositoryImpl>()),
  );
  sl.registerLazySingleton(() => SaveColorUseCase(sl()));
  sl.registerLazySingleton(() => GetLastColorsUseCase(sl()));

  // BLoC
  sl.registerFactory(
    () => ColorBloc(
      generateRandomColor: sl(),
      saveColor: sl(),
      getLastColors: sl(),
    ),
  );
}
