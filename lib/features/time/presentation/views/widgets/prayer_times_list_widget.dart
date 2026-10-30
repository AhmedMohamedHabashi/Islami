import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/features/time/domain/entities/prayer_time_entity.dart';

class PrayerTimesListWidget extends StatefulWidget {
  final List<PrayerTimeEntity> prayersList;

  const PrayerTimesListWidget({super.key, required this.prayersList});

  @override
  State<PrayerTimesListWidget> createState() => _PrayerTimesListWidgetState();
}

class _PrayerTimesListWidgetState extends State<PrayerTimesListWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToNextPrayer();
    });
  }

  void _scrollToNextPrayer() {
    if (widget.prayersList.isEmpty) return;

    int nextIndex = widget.prayersList.indexWhere((prayer) => prayer.isNext);
    if (nextIndex != -1) {
      double itemWidth = 90.w;
      double screenWidth = MediaQuery.of(context).size.width;

      double targetOffset =
          (nextIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);
      if (targetOffset < 0) targetOffset = 0;

      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.prayersList.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 150.h,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemCount: widget.prayersList.length,
        itemBuilder: (context, index) {
          final prayer = widget.prayersList[index];
          final bool isNext = prayer.isNext;

          final timeParts = prayer.time.split(' ');
          final String timeOnly = timeParts.isNotEmpty
              ? timeParts[0]
              : prayer.time;
          final String periodOnly = timeParts.length > 1 ? timeParts[1] : '';

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
                    prayer.name,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body14.copyWith(
                      color: AppColors.white,
                      fontSize: isNext ? 16.sp : 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    timeOnly,
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
                    periodOnly,
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
