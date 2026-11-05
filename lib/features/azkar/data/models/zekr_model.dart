import 'package:islami/features/azkar/domain/entities/azkar_entity.dart';

class ZekrModel {
  final String category;
  final String zekr;

  ZekrModel({required this.category, required this.zekr});

  factory ZekrModel.fromJson(Map<String, dynamic> json) {
    return ZekrModel(
      category: json['category'] ?? '',
      zekr: json['zekr'] ?? '',
    );
  }

  ZekrEntity toEntity() {
    return ZekrEntity(category: category, zekr: zekr);
  }
}
