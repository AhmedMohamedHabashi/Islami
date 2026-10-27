import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'prayer_times_list_widget.dart';

class TimeHeaderWidget extends StatelessWidget {
  const TimeHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
              '16 Jul,\n2024',
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.center,
              style: AppTextStyles.body14.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            top: 12.h,
            right: 20.w,
            child: Text(
              '09 Muh,\n1446',
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
                  Text(
                    'Tuesday',
                    style: AppTextStyles.body20.copyWith(
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  const PrayerTimesListWidget(),

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
                            text: TextSpan(
                              text: 'Next Pray - ',
                              style: AppTextStyles.body16.copyWith(
                                color: AppColors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: '02:32',
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
                          child: Icon(
                            Icons.volume_off_rounded,
                            color: AppColors.black,
                            size: 30.r,
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
  }
}

class HeaderCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double w = size.width;
    double h = size.height;

    double domeWidth = 190.w;
    double domeHeight = 65.h;
    double startX = (w - domeWidth) / 2;
    double endX = startX + domeWidth;

    path.moveTo(0, h);
    path.lineTo(w, h);
    path.lineTo(w, domeHeight + 15.h);

    path.quadraticBezierTo(w, domeHeight, w - 25.r, domeHeight);

    path.lineTo(endX + 30.w, domeHeight);
    path.quadraticBezierTo(
      endX + 5.w,
      domeHeight,
      endX - 5.w,
      domeHeight - 15.h,
    );
    path.quadraticBezierTo(endX - 25.w, 0, endX - 45.w, 0);

    path.lineTo(startX + 45.w, 0);

    path.quadraticBezierTo(startX + 25.w, 0, startX + 5.w, domeHeight - 15.h);
    path.quadraticBezierTo(startX - 5.w, domeHeight, startX - 30.w, domeHeight);

    path.lineTo(25.r, domeHeight);
    path.quadraticBezierTo(0, domeHeight, 0, domeHeight + 15.h);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
