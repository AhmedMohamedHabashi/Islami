import 'dart:typed_data';

import 'package:injectable/injectable.dart';
import 'package:record/record.dart';

import 'package:islami/core/errors/exceptions.dart';

@lazySingleton
class AudioRecordingDataSource {
  final AudioRecorder _recorder = AudioRecorder();

  bool _isRecording = false;
  Stream<Uint8List>? _audioStream;

  bool get isRecording => _isRecording;

  Future<Stream<Uint8List>> startRecording() async {
    if (_isRecording) {
      if (_audioStream != null) return _audioStream!;
      throw AudioRecordingException();
    }

    try {
      final hasPermission = await _recorder.hasPermission();

      if (!hasPermission) {
        throw MicrophonePermissionException();
      }

      final stream = await _recorder.startStream(
        const RecordConfig(
          encoder: AudioEncoder.pcm16bits,
          sampleRate: 16000,
          numChannels: 1,
        ),
      );

      _audioStream = stream;
      _isRecording = true;

      return stream;
    } on MicrophonePermissionException {
      rethrow;
    } catch (_) {
      _isRecording = false;
      _audioStream = null;
      throw AudioRecordingException();
    }
  }

  Future<void> stopRecording() async {
    if (!_isRecording) return;

    try {
      await _recorder.stop();

      _isRecording = false;
      _audioStream = null;
    } catch (_) {
      throw AudioRecordingException();
    }
  }

  Future<void> dispose() async {
    var hasError = false;

    try {
      if (_isRecording) {
        await _recorder.stop();
      }
    } catch (_) {
      hasError = true;
    }

    try {
      await _recorder.dispose();
    } catch (_) {
      hasError = true;
    } finally {
      _isRecording = false;
      _audioStream = null;
    }

    if (hasError) {
      throw AudioRecordingException();
    }
  }
}
