import 'dart:math' as math;
import 'dart:typed_data';

class VoiceActivityDetector {
  final double silenceThreshold;
  final int sampleRate;
  final int bytesPerSample;
  final Duration silenceLimit;

  double _currentRms = 0;
  Duration _silenceDuration = Duration.zero;
  bool _hasSpeech = false;

  VoiceActivityDetector({
    this.silenceThreshold = 500,
    this.sampleRate = 16000,
    this.bytesPerSample = 2,
    this.silenceLimit = const Duration(seconds: 3),
  });

  bool get hasReachedSilenceLimit => _silenceDuration >= silenceLimit;

  double calculateRms(Uint8List audioData) {
    if (audioData.length < 2) return 0;

    final samples = audioData.length ~/ bytesPerSample;

    if (samples == 0) return 0;

    double sumOfSquares = 0;

    for (int i = 0; i < samples; i++) {
      final offset = i * bytesPerSample;

      int sample = audioData[offset] | (audioData[offset + 1] << 8);

      if (sample >= 0x8000) {
        sample -= 0x10000;
      }

      sumOfSquares += sample * sample;
    }

    return math.sqrt(sumOfSquares / samples);
  }

  bool processChunk(Uint8List audioData) {
    _currentRms = calculateRms(audioData);
    _hasSpeech = _currentRms >= silenceThreshold;

    if (_hasSpeech) {
      _silenceDuration = Duration.zero;
    } else {
      final chunkDuration = Duration(
        microseconds:
            (audioData.length * 1000000) ~/ (sampleRate * bytesPerSample),
      );

      _silenceDuration += chunkDuration;
    }

    return _hasSpeech;
  }

  void reset() {
    _currentRms = 0;
    _silenceDuration = Duration.zero;
    _hasSpeech = false;
  }
}
