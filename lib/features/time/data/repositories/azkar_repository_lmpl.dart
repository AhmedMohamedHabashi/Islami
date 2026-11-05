import 'package:injectable/injectable.dart';
import 'package:islami/core/constants/app_assets.dart';
import 'package:islami/features/azkar/domain/entities/azkar_entity.dart';
import 'package:islami/features/time/data/datasources/azkar_remote_data_source.dart';
import 'package:islami/features/time/data/models/azkar_category_model.dart';
import 'package:islami/features/time/domain/entities/azkar_category_entity.dart';
import 'package:islami/features/time/domain/repositories/azkar_repository.dart';

@LazySingleton(as: AzkarRepository)
class AzkarRepositoryImpl implements AzkarRepository {
  final AzkarRemoteDataSource remoteDataSource;

  AzkarRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<AzkarCategoryEntity>> getAzkarCategories() async {
    final zekrModels = await remoteDataSource.fetchAllAzkar();

    final Map<String, AzkarCategoryModel> uniqueCategories = {};

    for (var item in zekrModels) {
      bool isAzkarCategory = item.category.contains('أذكار');

      if (isAzkarCategory && !uniqueCategories.containsKey(item.category)) {
        uniqueCategories[item.category] = AzkarCategoryModel(
          title: item.category,
        );
      }
    }

    return uniqueCategories.values
        .map(
          (model) => AzkarCategoryEntity(
            title: model.title,
            iconPath: _getCategoryIcon(model.title),
          ),
        )
        .toList();
  }

  @override
  Future<List<ZekrEntity>> getZkarsByCategory(String categoryName) async {
    final zekrModels = await remoteDataSource.fetchAllAzkar();

    final filteredModels = zekrModels
        .where((item) => item.category == categoryName)
        .toList();

    return filteredModels.map((model) => model.toEntity()).toList();
  }

  String _getCategoryIcon(String categoryName) {
    if (categoryName.contains('الصباح')) {
      return AppAssets.morningazkar;
    } else if (categoryName.contains('المساء')) {
      return AppAssets.eveningazkar;
    } else if (categoryName.contains('الاستيقاظ')) {
      return AppAssets.wakeupAzkar;
    } else if (categoryName.contains('الآذان')) {
      return AppAssets.azkarAzan;
    } else if (categoryName.contains('السلام من الصلاة')) {
      return AppAssets.azkarAfterPrayer;
    } else if (categoryName.contains('النوم')) {
      return AppAssets.sleepAzkar;
    } else {
      return AppAssets.morningazkar;
    }
  }
}
