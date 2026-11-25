import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/core/api/api_constants.dart';
import 'package:islami/core/api/dio_factory.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/features/home/data/datasources/home_local_data_source.dart';
import 'package:islami/features/home/data/datasources/home_remote_data_source.dart';
import 'package:islami/features/home/data/repositories/home_repository_impl.dart';
import 'package:islami/features/home/domain/usecases/get_home_recent_surahs_usecase.dart';
import 'package:islami/features/home/domain/usecases/get_home_surahs_usecase.dart';
import 'package:islami/features/home/presentation/cubit/home_cubit.dart';
import 'package:islami/features/home/presentation/views/home_body.dart';
import 'package:islami/features/home/presentation/views/widgets/petals_fab.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _createCubit()..load(),
      child: const Scaffold(
        backgroundColor: AppColors.primaryBackground,
        floatingActionButton: PetalsFab(),
        body: HomeBody(),
      ),
    );
  }

  HomeCubit _createCubit() {
    final repository = HomeRepositoryImpl(
      remoteDataSource: HomeRemoteDataSource(
        dio: DioFactory.createDio(ApiConstants.smartquranBaseUrl),
      ),
      localDataSource: HomeLocalDataSource(),
    );

    return HomeCubit(
      getSurahs: GetHomeSurahsUseCase(repository: repository),
      getRecentSurahs: GetHomeRecentSurahsUseCase(repository: repository),
    );
  }
}
