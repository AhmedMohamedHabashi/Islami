import 'package:equatable/equatable.dart';

class SurahEntity extends Equatable {
  final int number;
  final String nameEn;
  final String nameAr;
  final int versesCount;

  const SurahEntity({
    required this.number,
    required this.nameEn,
    required this.nameAr,
    required this.versesCount,
  });

  @override
  List<Object?> get props => [number, nameEn, nameAr, versesCount];
}
