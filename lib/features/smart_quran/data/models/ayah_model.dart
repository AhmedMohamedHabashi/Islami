import '../../domain/entities/ayah.dart';

class AyahModel extends Ayah {
  const AyahModel({required super.numberInSurah, required super.text});

  factory AyahModel.fromJson(Map<String, dynamic> json) {
    return AyahModel(
      numberInSurah: json['numberInSurah'] as int,
      text: json['text'] as String,
    );
  }
}
