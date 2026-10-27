import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class PrayerTimesListWidget extends StatelessWidget {
  const PrayerTimesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyPrayers = [
      {'name': 'Sunrise', 'time': '05:04', 'period': 'AM', 'isNext': false},
      {'name': 'Dhuhr', 'time': '01:01', 'period': 'PM', 'isNext': false},
      {'name': 'ASR', 'time': '04:38', 'period': 'PM', 'isNext': true},
      {'name': 'Maghrib', 'time': '07:57', 'period': 'PM', 'isNext': false},
      {'name': 'Isha', 'time': '09:12', 'period': 'PM', 'isNext': false},
    ];

    return SizedBox(
      height: 150.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemCount: dummyPrayers.length,
        itemBuilder: (context, index) {
          final prayer = dummyPrayers[index];
          final isNext = prayer['isNext'] as bool;

          return Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: isNext ? 104.w : 86.w,
              height: isNext ? 128.h : 106.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 6.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  begin: const Alignment(-0.88, -0.47),
                  end: const Alignment(0.88, 0.47),
                  colors: [
                    AppColors.time3Background,
                    AppColors.time2Background,
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    prayer['name'],
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body14.copyWith(
                      color: AppColors.white,
                      fontSize: isNext ? 16.sp : 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  Text(
                    prayer['time'],
                    textAlign: TextAlign.center,
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.white,
                      fontSize: isNext ? 32.sp : 24.sp,
                      fontWeight: FontWeight.bold,
                      height: 1.0,
                    ),
                  ),
                  SizedBox(height: 8.h),

                  Text(
                    prayer['period'],
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body12.copyWith(
                      color: AppColors.white,
                      fontSize: isNext ? 16.sp : 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
