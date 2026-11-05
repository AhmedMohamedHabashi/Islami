import 'package:islami/features/azkar/domain/entities/azkar_entity.dart';
import 'package:islami/features/time/domain/entities/azkar_category_entity.dart'; // تأكد من استيراد كلاس إنتيتي الذكر

abstract class AzkarRepository {
  Future<List<AzkarCategoryEntity>> getAzkarCategories();

  Future<List<ZekrEntity>> getZkarsByCategory(String categoryName);
}
