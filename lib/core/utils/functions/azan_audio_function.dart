import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:islami/features/time/presentation/cubit/prayer_times/prayer_times_state.dart';

class AzanAudioFunction {
  bool isMuted = false;
  bool _isAzanPlaying = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  PrayerTimesLoaded? pendingState;

  bool get isAzanPlaying => _isAzanPlaying;

  Future<void> toggleMute() async {
    isMuted = !isMuted;
    if (isMuted) {
      await _audioPlayer.setVolume(0.0);
    } else {
      await _audioPlayer.setVolume(1.0);
    }
  }

  Future<void> playAzan(VoidCallback onAzanFinished) async {
    if (!_isAzanPlaying) {
      try {
        _isAzanPlaying = true;
        await _audioPlayer.stop();

        await _audioPlayer.setVolume(1.0);
        isMuted = false;

        await _audioPlayer.play(AssetSource('audio/azan.mp3'));

        Future.delayed(const Duration(minutes: 3, seconds: 6), () {
          _isAzanPlaying = false;
          onAzanFinished();
          pendingState = null;
        });
      } catch (e) {
        _isAzanPlaying = false;
        debugPrint('خطأ في تشغيل صوت الأذان: $e');
      }
    }
  }

  void dispose() {
    _audioPlayer.dispose();
  }
}
