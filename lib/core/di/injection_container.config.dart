// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/azkar/domain/usecases/get_zkars_by_category_usecase.dart'
    as _i476;
import '../../features/azkar/presentaion/cubit/azkar/azkar_details_cubit.dart'
    as _i870;
import '../../features/time/data/datasources/azkar_remote_data_source.dart'
    as _i154;
import '../../features/time/data/datasources/prayer_remote_data_source.dart'
    as _i545;
import '../../features/time/data/repositories/azkar_repository_lmpl.dart'
    as _i721;
import '../../features/time/data/repositories/prayer_times_repository_impl.dart'
    as _i380;
import '../../features/time/domain/repositories/azkar_repository.dart' as _i722;
import '../../features/time/domain/repositories/prayer_times_repository.dart'
    as _i591;
import '../../features/time/domain/usecases/get_azkar_categories_usecase.dart'
    as _i1028;
import '../../features/time/domain/usecases/get_prayer_header_use_case.dart'
    as _i285;
import '../../features/time/domain/usecases/get_prayer_times_list_use_case.dart'
    as _i406;
import '../../features/time/presentation/cubit/azkar/oazkar_cubit.dart'
    as _i558;
import '../../features/time/presentation/cubit/prayer_times/prayer_times_cubit.dart'
    as _i943;
import '../network/network_info.dart' as _i932;
import '../network/network_info_impl.dart' as _i865;
import '../services/location_service.dart' as _i669;
import 'modules/register_module.dart' as _i911;

// initializes the registration of main-scope dependencies inside of GetIt
_i174.GetIt $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i526.GetItHelper(getIt, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i895.Connectivity>(() => registerModule.connectivity);
  gh.lazySingleton<_i669.LocationService>(() => _i669.LocationService());
  gh.lazySingleton<_i361.Dio>(
    () => registerModule.azkarDio,
    instanceName: 'azkarDio',
  );
  gh.lazySingleton<_i154.AzkarRemoteDataSource>(
    () => _i154.AzkarRemoteDataSource(gh<_i361.Dio>(instanceName: 'azkarDio')),
  );
  gh.lazySingleton<_i361.Dio>(
    () => registerModule.dio,
    instanceName: 'prayerDio',
  );
  gh.lazySingleton<_i932.NetworkInfo>(
    () => _i865.NetworkInfoImpl(gh<_i895.Connectivity>()),
  );
  gh.lazySingleton<_i545.PrayerRemoteDataSource>(
    () =>
        _i545.PrayerRemoteDataSource(gh<_i361.Dio>(instanceName: 'prayerDio')),
  );
  gh.lazySingleton<_i722.AzkarRepository>(
    () => _i721.AzkarRepositoryImpl(
      remoteDataSource: gh<_i154.AzkarRemoteDataSource>(),
    ),
  );
  gh.lazySingleton<_i476.GetZkarsByCategoryUseCase>(
    () => _i476.GetZkarsByCategoryUseCase(gh<_i722.AzkarRepository>()),
  );
  gh.lazySingleton<_i1028.GetAzkarCategoriesUseCase>(
    () => _i1028.GetAzkarCategoriesUseCase(gh<_i722.AzkarRepository>()),
  );
  gh.factory<_i558.AzkarCubit>(
    () => _i558.AzkarCubit(
      getAzkarCategoriesUseCase: gh<_i1028.GetAzkarCategoriesUseCase>(),
    ),
  );
  gh.lazySingleton<_i591.PrayerTimesRepository>(
    () => _i380.PrayerTimesRepositoryImpl(
      remoteDataSource: gh<_i545.PrayerRemoteDataSource>(),
    ),
  );
  gh.factory<_i870.AzkarDetailsCubit>(
    () => _i870.AzkarDetailsCubit(gh<_i476.GetZkarsByCategoryUseCase>()),
  );
  gh.lazySingleton<_i285.GetPrayerHeaderUseCase>(
    () => _i285.GetPrayerHeaderUseCase(gh<_i591.PrayerTimesRepository>()),
  );
  gh.lazySingleton<_i406.GetPrayerTimesListUseCase>(
    () => _i406.GetPrayerTimesListUseCase(gh<_i591.PrayerTimesRepository>()),
  );
  gh.factory<_i943.PrayerTimesCubit>(
    () => _i943.PrayerTimesCubit(
      getPrayerHeaderUseCase: gh<_i285.GetPrayerHeaderUseCase>(),
      getPrayerTimesListUseCase: gh<_i406.GetPrayerTimesListUseCase>(),
      locationService: gh<_i669.LocationService>(),
    ),
  );
  return getIt;
}

class _$RegisterModule extends _i911.RegisterModule {}
