import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/constants/app_assets.dart';
import 'package:islami/core/shared/widgets/header/islami_header.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/utils/functions/arabic_ordinal_function.dart';
import 'package:islami/features/azkar/presentaion/cubit/azkar/azkar_details_cubit.dart';
import 'package:islami/features/azkar/presentaion/cubit/azkar/azkar_details_state.dart';
import 'package:islami/core/shared/widgets/content_view/contant_layout.dart';

class AzkarView extends StatelessWidget {
  final String categoryTitle;

  const AzkarView({super.key, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAssets.azkarBackground, fit: BoxFit.cover),
          ),
          SafeArea(
            child: Column(
              children: [
                const IslamiHeader(small: true),
                Expanded(
                  child: BlocBuilder<AzkarDetailsCubit, AzkarDetailsState>(
                    builder: (context, state) {
                      if (state is AzkarDetailsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      } else if (state is AzkarDetailsError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(
                              color: AppColors.errColor,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else if (state is AzkarDetailsLoaded) {
                        final zkarsList = state.zkarsList;

                        if (zkarsList.isEmpty) {
                          return const Center(
                            child: Text(
                              'لا توجد أذكار مضافة حالياً',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                              ),
                            ),
                          );
                        }

                        return ContantLayout(
                          items: zkarsList,
                          getContent: (azkar) => azkar.zekr,
                          onItemTap: (azkar) {
                            int index = zkarsList.indexOf(azkar);

                            String computedTitle =
                                'الذكر ${ArabicOrdinalFunction.getOrdinal(index + 1)}';

                            context.push(
                              RouteNames.azkardetails,
                              extra: {'zekr': azkar, 'title': computedTitle},
                            );
                          },
                          prefixText: 'الذكر',
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
