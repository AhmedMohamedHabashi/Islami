import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/helpers/localization_extension.dart';
import 'package:islami/features/time/domain/entities/azkar_category_entity.dart';
import 'package:islami/features/time/presentation/cubit/azkar/azkar_state.dart';
import 'package:islami/features/time/presentation/cubit/azkar/oazkar_cubit.dart';

class AzkarSectionWidget extends StatelessWidget {
  const AzkarSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.azkarSectionHeader,
          style: AppTextStyles.body20.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 12.h),

        BlocBuilder<AzkarCubit, AzkarState>(
          builder: (context, state) {
            if (state is AzkarLoading) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              );
            } else if (state is AzkarLoaded) {
              final categories = state.categoriesList;

              return GridView.builder(
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
              );
            } else if (state is AzkarError) {
              return Center(
                child: Text(
                  state.message,
                  style: AppTextStyles.body16.copyWith(
                    color: AppColors.errColor,
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
        SizedBox(height: 15.h),
      ],
    );
  }

  Widget _buildAzkarCard(BuildContext context, AzkarCategoryEntity category) {
    return Material(
      color: AppColors.time3Background,
      borderRadius: BorderRadius.circular(20.r),
      child: InkWell(
        onTap: () {
          context.push(RouteNames.azkar, extra: category.title);
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
                  context.translateAzkarTitle(category.title),
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
