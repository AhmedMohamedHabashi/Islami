import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/shared/widgets/header/islami_header.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/features/home/presentation/constants/home_assets.dart';
import 'package:islami/features/home/presentation/constants/home_strings.dart';
import 'package:islami/features/home/presentation/cubit/home_cubit.dart';
import 'package:islami/features/home/presentation/views/widgets/home_search_field.dart';
import 'package:islami/features/home/presentation/views/widgets/recent_surahs_section.dart';
import 'package:islami/features/home/presentation/views/widgets/surah_list_item.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          HomeAssets.background,
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        ColoredBox(color: AppColors.primaryBackground.withValues(alpha: 0.5)),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                return CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: _buildHeader(context)),
                    ..._buildContent(context, state),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        const IslamiHeader(small: true),
        SizedBox(height: 12.h),
        HomeSearchField(onChanged: context.read<HomeCubit>().search),
        SizedBox(height: 16.h),
      ],
    );
  }

  List<Widget> _buildContent(BuildContext context, HomeState state) {
    if (state.status == HomeStatus.initial ||
        state.status == HomeStatus.loading) {
      return const [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        ),
      ];
    }

    if (state.status == HomeStatus.failure) {
      return [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  state.errorMessage,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body14.copyWith(color: AppColors.white),
                ),
                TextButton(
                  onPressed: () => context.read<HomeCubit>().load(),
                  child: Text(
                    HomeStrings.retry,
                    style: AppTextStyles.body14.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ];
    }

    final surahs = state.filteredSurahs;

    return [
      if (!state.isSearching)
        SliverToBoxAdapter(
          child: RecentSurahsSection(surahs: state.recentSurahs),
        ),
      if (!state.isSearching)
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Text(
              HomeStrings.surasList,
              style: AppTextStyles.body16.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      if (surahs.isEmpty)
        SliverFillRemaining(
          hasScrollBody: false,
          child: Center(
            child: Text(
              HomeStrings.noResults,
              style: AppTextStyles.body14.copyWith(color: AppColors.white),
            ),
          ),
        )
      else
        SliverList.builder(
          itemCount: surahs.length,
          itemBuilder: (_, i) => SurahListItem(
            surah: surahs[i],
            showDivider: i != surahs.length - 1,
          ),
        ),
    ];
  }
}
