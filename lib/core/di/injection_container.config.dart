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

import '../../features/time/data/datasources/prayer_remote_data_source.dart'
    as _i545;
import '../../features/time/data/repositories/prayer_times_repository_impl.dart'
    as _i380;
import '../../features/time/domain/repositories/prayer_times_repository.dart'
    as _i591;
import '../../features/time/domain/usecases/GetPrayerHeaderUseCase.dart'
    as _i867;
import '../../features/time/domain/usecases/GetPrayerTimesListUseCase.dart'
    as _i850;
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
  gh.lazySingleton<_i591.PrayerTimesRepository>(
    () => _i380.PrayerTimesRepositoryImpl(
      remoteDataSource: gh<_i545.PrayerRemoteDataSource>(),
    ),
  );
  gh.lazySingleton<_i867.GetPrayerHeaderUseCase>(
    () => _i867.GetPrayerHeaderUseCase(gh<_i591.PrayerTimesRepository>()),
  );
  gh.lazySingleton<_i850.GetPrayerTimesListUseCase>(
    () => _i850.GetPrayerTimesListUseCase(gh<_i591.PrayerTimesRepository>()),
  );
  gh.factory<_i943.PrayerTimesCubit>(
    () => _i943.PrayerTimesCubit(
      getPrayerHeaderUseCase: gh<_i867.GetPrayerHeaderUseCase>(),
      getPrayerTimesListUseCase: gh<_i850.GetPrayerTimesListUseCase>(),
      locationService: gh<_i669.LocationService>(),
    ),
  );
  return getIt;
}

class _$RegisterModule extends _i911.RegisterModule {}
