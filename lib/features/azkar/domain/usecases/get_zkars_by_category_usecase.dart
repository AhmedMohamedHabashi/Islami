import 'package:injectable/injectable.dart';
import 'package:islami/features/azkar/domain/entities/azkar_entity.dart';
import 'package:islami/features/time/domain/repositories/azkar_repository.dart';

@LazySingleton()
class GetZkarsByCategoryUseCase {
  final AzkarRepository repository;

  GetZkarsByCategoryUseCase(this.repository);

  Future<List<ZekrEntity>> call(String categoryName) async {
    return await repository.getZkarsByCategory(categoryName);
  }
}
