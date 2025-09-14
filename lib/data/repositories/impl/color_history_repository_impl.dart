import 'package:color_generate/data/datasources/color_history_data_source.dart';
import 'package:color_generate/data/models/color_history_model.dart';
import 'package:color_generate/domain/entities/color_info.dart';
import 'package:color_generate/domain/repositories/color_history_repository.dart';

/// Implementation of [ColorHistoryRepository] that uses a [ColorHistoryDataSource].
class ColorHistoryRepositoryImpl implements ColorHistoryRepository {
  final ColorHistoryDataSource _dataSource;

  /// Creates a new [ColorHistoryRepositoryImpl] instance.
  ColorHistoryRepositoryImpl({required ColorHistoryDataSource dataSource})
    : _dataSource = dataSource;

  @override
  Future<List<ColorInfo>> getLastColors() async {
    final models = await _dataSource.getLastColors();
    return models.map((model) => ColorInfo(color: model.toColor())).toList();
  }

  @override
  Future<void> saveColor(ColorInfo color) async {
    final model = ColorHistoryModel.fromColor(color.color);
    await _dataSource.saveColor(model);
  }
}
