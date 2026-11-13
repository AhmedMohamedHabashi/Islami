import 'package:equatable/equatable.dart';

class Ayah extends Equatable {
  final int numberInSurah;
  final String text;

  const Ayah({required this.numberInSurah, required this.text});

  @override
  List<Object?> get props => [numberInSurah, text];
}
