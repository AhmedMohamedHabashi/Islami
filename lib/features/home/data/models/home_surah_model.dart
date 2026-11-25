import 'package:islami/core/utils/helpers/arabic_text_utils.dart';
import 'package:islami/features/home/domain/entities/surah_entity.dart';

class HomeSurahModel extends SurahEntity {
  const HomeSurahModel({
    required super.number,
    required super.nameEn,
    required super.nameAr,
    required super.versesCount,
  });

  factory HomeSurahModel.fromJson(Map<String, dynamic> json) {
    return HomeSurahModel(
      number: json['number'] as int,
      nameEn: json['englishName'] as String,
      nameAr: ArabicTextUtils.cleanSurahName(json['name'] as String),
      versesCount: json['numberOfAyahs'] as int,
    );
  }
}
