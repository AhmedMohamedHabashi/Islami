import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/app_sizes.dart';

class AyahCardFooter extends StatelessWidget {
  final int startAyah;
  final int endAyah;

  const AyahCardFooter({
    super.key,
    required this.startAyah,
    required this.endAyah,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Bottom decoration.
        Row(
          children: [
            Expanded(child: _goldLine()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Icon(
                Icons.diamond_outlined,
                color: AppColors.primary,
                size: AppSizes.icon14,
              ),
            ),
            Expanded(child: _goldLine()),
          ],
        ),

        SizedBox(height: AppSizes.size5H),

        // Selected ayah range.
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_rounded,
              color: AppColors.white.withValues(alpha: 0.65),
              size: AppSizes.icon14,
            ),

            SizedBox(width: AppSizes.size6W),

            Flexible(
              child: Text(
                'من الآية $startAyah إلى الآية $endAyah',
                textAlign: TextAlign.center,
                style: AppTextStyles.body12.copyWith(
                  color: AppColors.white.withValues(alpha: 0.65),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _goldLine() {
    return Container(
      height: AppSizes.size1H,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(AppSizes.radius2),
      ),
    );
  }
}
