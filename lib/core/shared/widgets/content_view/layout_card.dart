import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_assets.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class LayoutCard extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback? onTap;

  const LayoutCard({
    super.key,
    required this.title,
    required this.content,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 310.w,
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20.r),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Image.asset(AppAssets.azkarCard, fit: BoxFit.fill),
                ),
              ),

              Positioned.fill(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 40.h,
                    horizontal: 24.w,
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.body24.copyWith(
                              color: AppColors.time3Background,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Text(
                            content,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.body16.copyWith(
                              color: AppColors.time3Background,
                              fontWeight: FontWeight.bold,
                              height: 1.7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
