import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/helpers/localization_extension.dart';
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
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<PrayerTimesCubit, PrayerTimesState>(
      builder: (context, state) {
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
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

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

        if (state is! PrayerTimesLoaded) {
          return const SizedBox.shrink();
        }

        final String formattedGregorianDate = context.formatGregorianDate(
          state.headerData.gregorianDate,
        );
        final String dayName = context.formatDayName(
          state.headerData.gregorianDate,
        );
        final String formattedHijriDate = context.formatHijriDate(
          state.headerData.hijriDay,
          state.headerData.hijriMonth,
          state.headerData.hijriYear,
        );

        final String rawNextPrayerTime = state.headerData.nextPrayTime;
        DateTime parsedNextTime;
        try {
          parsedNextTime = DateFormat('hh:mm a').parse(rawNextPrayerTime);
        } catch (e) {
          parsedNextTime = DateTime(2024, 1, 1, 12, 0);
        }
        final String translatedNextPrayerTime = context.formatTime(
          parsedNextTime,
        );

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
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    formattedGregorianDate,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body14.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // التاريخ الهجري
              Positioned(
                top: 12.h,
                right: 20.w,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    formattedHijriDate,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body14.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
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
                        l10n.prayTimeHeader,
                        style: AppTextStyles.body14.copyWith(
                          color: AppColors.black.withOpacity(0.7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        dayName,
                        style: AppTextStyles.body20.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 16.h),

                      PrayerTimesListWidget(prayersList: state.prayersList),

                      SizedBox(height: 14.h),

                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 16.h,
                          left: 24.w,
                          right: 24.w,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: RichText(
                                textDirection: Directionality.of(context),
                                text: TextSpan(
                                  text: '${l10n.nextPray} - ',
                                  style: AppTextStyles.body16.copyWith(
                                    color: AppColors.black,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: translatedNextPrayerTime,
                                      style: AppTextStyles.body16.copyWith(
                                        color: AppColors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  prayerCubit.toggleMuteSound();
                                },
                                child: Icon(
                                  isMuted
                                      ? Icons.volume_off_rounded
                                      : Icons.volume_up_rounded,
                                  color: AppColors.black,
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
