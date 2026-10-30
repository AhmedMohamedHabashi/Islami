import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/features/time/presentation/cubit/prayer_times/prayer_times_cubit.dart';
import 'package:islami/features/time/presentation/cubit/prayer_times/prayer_times_state.dart';
import 'package:islami/features/time/presentation/views/widgets/header_curve_clipper.dart';
import 'prayer_times_list_widget.dart';

class TimeHeaderWidget extends StatefulWidget {
  const TimeHeaderWidget({super.key});

  @override
  State<TimeHeaderWidget> createState() => _TimeHeaderWidgetState();
}

class _TimeHeaderWidgetState extends State<TimeHeaderWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
        // 1. حالة التحميل (Loading)
        if (state is PrayerTimesLoading) {
          return Container(
            width: double.infinity,
            height: 250.h,
            decoration: BoxDecoration(
              color: AppColors.timeBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
                bottomLeft: Radius.circular(40.r),
                bottomRight: Radius.circular(40.r),
              ),
            ),
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.white),
            ),
          );
        }

        // 2. حالة الخطأ (Error)
        if (state is PrayerTimesError) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: AppColors.timeBackground,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Center(
              child: Text(
                'خطأ في التحميل: ${state.message}',
                style: AppTextStyles.body16.copyWith(color: Colors.redAccent),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // لو الحالة مش Loaded (احتياطاً)
        if (state is! PrayerTimesLoaded) {
          return const SizedBox.shrink();
        }

        // 3. الداتا الحقيقية وقت نجاح الجلب (Loaded)
        final String gregorianDate = state.headerData.gregorianDate;
        final String hijriDate = state.headerData.hijriDate;
        final String dayName = state.headerData.dayName;
        final String nextPrayerTime = state.headerData.nextPrayTime;

        // بنستدعي الكيوبت عشان نعرف حالة الكتم الحالية (isMuted)
        final prayerCubit = context.read<PrayerTimesCubit>();
        final bool isMuted = prayerCubit.isMuted;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.timeBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
              bottomLeft: Radius.circular(40.r),
              bottomRight: Radius.circular(40.r),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 12.h,
                left: 20.w,
                child: Text(
                  gregorianDate,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body14.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // التاريخ الهجري
              Positioned(
                top: 12.h,
                right: 20.w,
                child: Text(
                  hijriDate,
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body14.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              ClipPath(
                clipper: HeaderCurveClipper(),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.r),
                      bottomRight: Radius.circular(40.r),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        'Pray Time',
                        style: AppTextStyles.body14.copyWith(
                          color: AppColors.black.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      // اليوم
                      Text(
                        dayName,
                        style: AppTextStyles.body20.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // لستة الصلوات الحية
                      PrayerTimesListWidget(prayersList: state.prayersList),

                      SizedBox(height: 14.h),

                      // الجزء الخاص بـ Next Pray وزرار الصوت الأسود
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 16.h,
                          left: 24.w,
                          right: 24.w,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // نص Next Pray وجنبه الوقت القادم
                            Center(
                              child: RichText(
                                text: TextSpan(
                                  text: 'Next Pray - ',
                                  style: AppTextStyles.body16.copyWith(
                                    color: AppColors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: nextPrayerTime,
                                      style: AppTextStyles.body16.copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // زرار الصوت الأسود في أقصى اليمين (متصل بالكيوبت)
                            Positioned(
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  ;
                                  // بيغير حالة الصوت (كتم / تفعيل) وبيحدث الشاشة فوراً
                                  prayerCubit.toggleMuteSound();
                                },
                                child: Icon(
                                  isMuted
                                      ? Icons.volume_off_rounded
                                      : Icons.volume_up_rounded,
                                  color: AppColors.black, // لون أسود زي فيجما
                                  size: 30.r,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
