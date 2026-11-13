import 'package:islami/features/smart_quran/domain/entities/surah.dart';

class RecitationArgs {
  final Surah selectedSurah;
  final int startAyah;
  final int endAyah;
  final String selectedMode;

  const RecitationArgs({
    required this.selectedSurah,
    required this.startAyah,
    required this.endAyah,
    required this.selectedMode,
  });
}
