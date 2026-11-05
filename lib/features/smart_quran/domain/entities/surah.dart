import 'package:equatable/equatable.dart';

class Surah extends Equatable {
  final int number;
  final String name;
  final String englishName;
  final String englishNameTranslation;
  final int numberOfAyahs;
  final String revelationType;

  // Local user progress, not provided by Quran API.
  final int progress;
  final bool isSaved;

  const Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.englishNameTranslation,
    required this.numberOfAyahs,
    required this.revelationType,
    this.progress = 0,
    this.isSaved = false,
  });

  String get typeArabic => revelationType == 'Meccan' ? 'مكية' : 'مدنية';

  Surah copyWith({int? progress, bool? isSaved}) {
    return Surah(
      number: number,
      name: name,
      englishName: englishName,
      englishNameTranslation: englishNameTranslation,
      numberOfAyahs: numberOfAyahs,
      revelationType: revelationType,
      progress: progress ?? this.progress,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [
    number,
    name,
    englishName,
    englishNameTranslation,
    numberOfAyahs,
    revelationType,
    progress,
    isSaved,
  ];
}
