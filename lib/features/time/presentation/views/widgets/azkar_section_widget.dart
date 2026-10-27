import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/features/time/data/datasources/azkar_local_data_source.dart';
import 'package:islami/features/time/domain/entities/azkar_category_entity.dart';

class AzkarSectionWidget extends StatelessWidget {
  const AzkarSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = AzkarLocalDataSource.azkarCategories;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Azkar',
            style: AppTextStyles.body16.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: categories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 20.w,
              mainAxisSpacing: 20.h,
              childAspectRatio: 185 / 240,
            ),
            itemBuilder: (context, index) {
              final category = categories[index];
              return _buildAzkarCard(context, category);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAzkarCard(BuildContext context, AzkarCategoryEntity category) {
    return Material(
      color: AppColors.time3Background,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: () {
          // Navigation using category.id
        },
        borderRadius: BorderRadius.circular(20.r),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.primary, width: 1.5.w),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Image.asset(category.iconPath, fit: BoxFit.contain),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16.h, left: 8.w, right: 8.w),
                child: Text(
                  category.title,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body16.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
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
