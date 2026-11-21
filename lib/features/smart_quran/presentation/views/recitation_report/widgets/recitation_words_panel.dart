import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/utils/app_sizes.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation_report/widgets/ayah_end_marker.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation_report/widgets/recitation_word_chip.dart';
import '../../../../domain/entities/recitation_report.dart';

class RecitationWordsPanel extends StatelessWidget {
  final List<RecitationAyah> ayahs;
  final int? selectedWordId;
  final ValueChanged<int> onWordTap;

  const RecitationWordsPanel({
    super.key,
    required this.ayahs,
    required this.selectedWordId,
    required this.onWordTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.size12W,
        vertical: AppSizes.size18H,
      ),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppSizes.radius20),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.08)),
      ),
      child: Wrap(
        textDirection: TextDirection.rtl,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSizes.size8W,
        runSpacing: AppSizes.size14H,
        children: [
          for (final ayah in ayahs) ...[
            for (final word in ayah.words)
              RecitationWordChip(
                word: word,
                isSelected: word.id == selectedWordId,
                onTap: () => onWordTap(word.id),
              ),
            AyahEndMarker(ayahNumber: ayah.ayahNumber),
          ],
        ],
      ),
    );
  }
}
