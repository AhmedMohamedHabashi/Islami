import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/constants/app_assets.dart';
import 'package:islami/core/constants/app_icons.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  bool _hideBackground = false;

  @override
  void initState() {
    super.initState();

    _timer = Timer(const Duration(seconds: 3), () async {
      if (!mounted) return;

      setState(() {
        _hideBackground = true;
      });

      await Future.delayed(const Duration(milliseconds: 1200));

      if (!mounted) return;

      context.go(RouteNames.onboarding);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Stack(
        children: [
          Positioned.fill(
            child: AnimatedOpacity(
              opacity: _hideBackground ? 0 : 1,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              child: Image.asset(
                AppAssets.splashBackground,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: 180.h,
            left: 0,
            child: AnimatedOpacity(
              opacity: _hideBackground ? 0 : 1,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              child: Image.asset(AppAssets.shape1, width: 80.w),
            ),
          ),

          Positioned(
            bottom: 120.h,
            right: 0,
            child: AnimatedOpacity(
              opacity: _hideBackground ? 0 : 1,
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeInOut,
              child: Image.asset(AppAssets.shape2, width: 80.w),
            ),
          ),

          AnimatedPositioned(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOut,
            top: _hideBackground ? 45.h : 57.h,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                AppAssets.mosque,
                height: 190.h,
                fit: BoxFit.contain,
              ),
            ),
          ),

          Center(
            child: AnimatedScale(
              duration: const Duration(milliseconds: 700),
              curve: Curves.easeOutCubic,
              scale: _hideBackground ? 1.05 : 1,
              child: Image.asset(AppIcons.appIcon, scale: 2),
            ),
          ),

          Positioned(
            bottom: 50.h,
            left: 0,
            right: 0,
            child: Center(
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeInOut,
                opacity: _hideBackground ? 0.8 : 1,
                child: Text(
                  locale.welcome,
                  style: AppTextStyles.heading1.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
