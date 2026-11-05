import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:islami/core/utils/functions/azan_audio_function.dart';
import 'package:islami/features/time/domain/usecases/GetPrayerHeaderUseCase.dart';
import 'package:islami/features/time/domain/usecases/GetPrayerTimesListUseCase.dart';
import 'package:islami/features/time/presentation/cubit/prayer_times/prayer_times_state.dart';
import 'package:islami/core/errors/app_errors.dart';
import 'package:islami/core/errors/exceptions.dart';
import 'package:islami/core/services/location_service.dart';

@injectable
class PrayerTimesCubit extends Cubit<PrayerTimesState> {
  final GetPrayerHeaderUseCase getPrayerHeaderUseCase;
  final GetPrayerTimesListUseCase getPrayerTimesListUseCase;
  final LocationService locationService;
  Timer? _autoRefreshTimer;
  String? _lastNextPrayerTime;

  final AzanAudioFunction _azanAudioFunction = AzanAudioFunction();

  bool get isMuted => _azanAudioFunction.isMuted;

  PrayerTimesCubit({
    required this.getPrayerHeaderUseCase,
    required this.getPrayerTimesListUseCase,
    required this.locationService,
  }) : super(PrayerTimesInitial());

  void toggleMuteSound() {
    _azanAudioFunction.toggleMute();
    if (state is PrayerTimesLoaded) {
      final currentState = state as PrayerTimesLoaded;
      emit(
        PrayerTimesLoaded(
          headerData: currentState.headerData,
          prayersList: currentState.prayersList,
        ),
      );
    }
  }

  void _startAutoRefreshTimer(double latitude, double longitude, String date) {
    _autoRefreshTimer?.cancel();
    _autoRefreshTimer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (state is PrayerTimesLoaded) {
        fetchPrayerTimesSilently(
          latitude: latitude,
          longitude: longitude,
          date: date,
        );
      }
    });
  }

  Future<void> fetchPrayerTimesSilently({
    required double latitude,
    required double longitude,
    String? date,
  }) async {
    try {
      final finalDate = date ?? _getTodayFormattedDate();

      final headerData = await getPrayerHeaderUseCase(
        latitude: latitude,
        longitude: longitude,
        date: finalDate,
      );

      final prayersList = await getPrayerTimesListUseCase(
        latitude: latitude,
        longitude: longitude,
        date: finalDate,
      );

      String currentNextPrayer = headerData.nextPrayTime;

      if (_lastNextPrayerTime != null &&
          _lastNextPrayerTime != currentNextPrayer) {
        _azanAudioFunction.playAzan(() {
          if (state is PrayerTimesLoaded) {
            final currentState = state as PrayerTimesLoaded;
            emit(
              PrayerTimesLoaded(
                headerData: currentState.headerData,
                prayersList: currentState.prayersList,
              ),
            );
          }
        });
      }

      _lastNextPrayerTime = currentNextPrayer;

      final newState = PrayerTimesLoaded(
        headerData: headerData,
        prayersList: prayersList,
      );

      if (_azanAudioFunction.isAzanPlaying) {
        _azanAudioFunction.pendingState = newState;
        return;
      }

      emit(newState);
    } catch (_) {}
  }

  Future<void> fetchPrayerTimes({
    double? latitude,
    double? longitude,
    String? date,
  }) async {
    emit(PrayerTimesLoading());

    try {
      double finalLat = latitude ?? 0.0;
      double finalLng = longitude ?? 0.0;

      if (finalLat == 0.0 || finalLng == 0.0) {
        Map<String, double> coordinates = await locationService
            .getCurrentCoordinates();
        finalLat = coordinates['latitude'] ?? 30.0444;
        finalLng = coordinates['longitude'] ?? 31.2357;
      }

      final finalDate = date ?? _getTodayFormattedDate();

      final headerData = await getPrayerHeaderUseCase(
        latitude: finalLat,
        longitude: finalLng,
        date: finalDate,
      );

      final prayersList = await getPrayerTimesListUseCase(
        latitude: finalLat,
        longitude: finalLng,
        date: finalDate,
      );

      _lastNextPrayerTime = headerData.nextPrayTime;

      emit(PrayerTimesLoaded(headerData: headerData, prayersList: prayersList));

      _startAutoRefreshTimer(finalLat, finalLng, finalDate);
    } catch (e) {
      _handleError(e);
    }
  }

  String _getTodayFormattedDate() {
    final now = DateTime.now();
    String day = now.day.toString().padLeft(2, '0');
    String month = now.month.toString().padLeft(2, '0');
    String year = now.year.toString();

    return '$day-$month-$year';
  }

  void _handleError(Object e) {
    if (e is NetworkException) {
      emit(PrayerTimesError(message: AppErrors.networkError));
    } else if (e is AppTimeoutException) {
      emit(PrayerTimesError(message: AppErrors.timeoutError));
    } else if (e is ServerException) {
      emit(PrayerTimesError(message: AppErrors.serverError));
    } else {
      emit(PrayerTimesError(message: AppErrors.unexpectedError));
    }
  }

  @override
  Future<void> close() {
    _autoRefreshTimer?.cancel();
    _azanAudioFunction.dispose();
    return super.close();
  }
}
