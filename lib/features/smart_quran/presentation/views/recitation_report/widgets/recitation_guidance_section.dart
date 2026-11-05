import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation_report/widgets/recitation_guidance_card.dart';

import '../../../../domain/entities/recitation_report.dart';

class RecitationGuidanceSection extends StatelessWidget {
  final List<RecitationGuidance> guidance;

  const RecitationGuidanceSection({super.key, required this.guidance});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.recitationGuidanceTitle,
          style: AppTextStyles.body14.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12.h),
        for (final item in guidance) ...[
          RecitationGuidanceCard(guidance: item),
          SizedBox(height: 10.h),
        ],
      ],
    );
  }
}
