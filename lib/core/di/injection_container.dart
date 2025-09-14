import 'package:get_it/get_it.dart';
import 'package:color_generate/core/database/database_provider.dart';
import 'package:color_generate/data/datasources/color_history_data_source.dart';
import 'package:color_generate/data/datasources/impl/color_history_data_source_impl.dart';
import 'package:color_generate/data/repositories/color_repository_impl.dart';
import 'package:color_generate/data/repositories/impl/color_history_repository_impl.dart';
import 'package:color_generate/domain/repositories/color_history_repository.dart';
import 'package:color_generate/domain/usecases/generate_random_color.dart';
import 'package:color_generate/domain/usecases/get_last_colors.dart';
import 'package:color_generate/domain/usecases/save_color.dart';
import 'package:color_generate/presentation/bloc/color_bloc.dart';

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
