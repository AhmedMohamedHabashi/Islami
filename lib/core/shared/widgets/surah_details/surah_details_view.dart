import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_assets.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/shared/widgets/surah_details/custom_app_bar.dart';

class SurahDetailsView extends StatelessWidget {
  final String appBarTitle;
  final String itemTitle;
  final String content;

  const SurahDetailsView({
    super.key,
    required this.appBarTitle,
    required this.itemTitle,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppAssets.azkardetailsBackground,
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                CustomAppBar(titleText: appBarTitle),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Column(
                      children: [
                        SizedBox(height: 15.h),

                        Text(
                          itemTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 25.h),

                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.w),
                              child: Text(
                                content,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 18.sp,
                                  height: 1.9,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
