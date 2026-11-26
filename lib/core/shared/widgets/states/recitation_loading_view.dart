import 'package:flutter/material.dart';
import 'package:islami/core/shared/widgets/states/loading_state_view.dart';
import 'package:islami/core/themes/colors/app_colors.dart';

class RecitationLoadingView extends StatelessWidget {
  const RecitationLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(child: LoadingStateView()),
    );
  }
}
