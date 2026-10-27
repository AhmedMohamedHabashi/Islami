import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/features/time/presentation/views/widgets/azkar_section_widget.dart';
import 'package:islami/features/time/presentation/views/widgets/time_header_widget.dart';

class TimeViewBody extends StatelessWidget {
  const TimeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            const TimeHeaderWidget(),

            SizedBox(height: 20.h),

            const AzkarSectionWidget(),
          ],
        ),
      ),
    );
  }
}
