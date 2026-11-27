import 'dart:typed_data';

abstract class AudioRecordingRepository {
  bool get isRecording;

  Future<Stream<Uint8List>> startRecording();

  Future<void> stopRecording();
}
