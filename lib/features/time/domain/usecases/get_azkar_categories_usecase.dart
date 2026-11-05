import 'package:injectable/injectable.dart';
import 'package:islami/features/time/domain/entities/azkar_category_entity.dart';
import 'package:islami/features/time/domain/repositories/azkar_repository.dart';

@LazySingleton()
class GetAzkarCategoriesUseCase {
  final AzkarRepository repository;

  GetAzkarCategoriesUseCase(this.repository);

  Future<List<AzkarCategoryEntity>> call() async {
    return await repository.getAzkarCategories();
  }
}
