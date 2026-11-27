import 'dart:typed_data';
import 'package:injectable/injectable.dart';
import 'package:islami/core/utils/helpers/error_handler.dart';
import '../../domain/repo/audio_recording_repository.dart';
import '../datasources/audio_recording_data_source.dart';

@LazySingleton(as: AudioRecordingRepository)
class AudioRecordingRepositoryImpl implements AudioRecordingRepository {
  final AudioRecordingDataSource dataSource;

  AudioRecordingRepositoryImpl({required this.dataSource});

  @override
  bool get isRecording => dataSource.isRecording;

  @override
  Future<Stream<Uint8List>> startRecording() {
    return ErrorHandler.handleErrors(() => dataSource.startRecording());
  }

  @override
  Future<void> stopRecording() {
    return ErrorHandler.handleErrors(() => dataSource.stopRecording());
  }
}
