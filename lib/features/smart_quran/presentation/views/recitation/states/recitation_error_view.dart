import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/shared/widgets/bouttons/custom_action_button.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/features/smart_quran/presentation/common/recitation_args.dart';
import 'package:islami/features/smart_quran/presentation/cubit/recitation/recitation_cubit.dart';

class RecitationErrorView extends StatelessWidget {
  final String message;
  final RecitationArgs args;

  const RecitationErrorView({
    super.key,
    required this.message,
    required this.args,
  });

  void _retry(BuildContext context) {
    context.read<RecitationCubit>().loadAyahs(
      surahNumber: args.selectedSurah.number,
      startAyah: args.startAyah,
      endAyah: args.endAyah,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.white),
              ),
              SizedBox(height: 16.h),
              CustomActionButton(
                title: 'إعادة المحاولة',
                icon: Icons.refresh,
                onPressed: () => _retry(context),
                isPrimary: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
