import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class AyahCardText extends StatelessWidget {
  final String ayahText;
  final String? highlightedWord;

  const AyahCardText({super.key, required this.ayahText, this.highlightedWord});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      textDirection: TextDirection.rtl,
      text: TextSpan(
        style: AppTextStyles.body24.copyWith(
          color: AppColors.primary,
          height: 1.7.h,
        ),
        children: _buildAyahSpans(),
      ),
    );
  }

  List<InlineSpan> _buildAyahSpans() {
    final word = highlightedWord;

    if (word == null || word.isEmpty) {
      return [TextSpan(text: ayahText)];
    }

    final start = ayahText.indexOf(word);

    if (start == -1) {
      return [TextSpan(text: ayahText)];
    }

    final end = start + word.length;

    return [
      if (start > 0) TextSpan(text: ayahText.substring(0, start)),

      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          decoration: BoxDecoration(
            color: AppColors.ayahCardGradientBottom,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.primary, width: 1.w),
          ),
          child: Text(
            word,
            style: AppTextStyles.body24.copyWith(
              color: AppColors.primary,
              height: 1.8.h,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),

      if (end < ayahText.length) TextSpan(text: ayahText.substring(end)),
    ];
  }
}
