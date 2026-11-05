import 'package:speech_to_text/speech_to_text.dart';

class RecitationSpeechService {
  final SpeechToText _speechToText = SpeechToText();

  bool _isInitialized = false;
  bool _isListening = false;

  bool get isInitialized => _isInitialized;
  bool get isListening => _isListening;

  Future<bool> initialize() async {
    if (_isInitialized) {
      return true;
    }

    try {
      _isInitialized = await _speechToText.initialize(
        onError: (error) {
          _isListening = false;
        },
        onStatus: (status) {
          if (status == 'done' || status == 'notListening') {
            _isListening = false;
          }
        },
      );
      return _isInitialized;
    } catch (_) {
      _isInitialized = false;
      return false;
    }
  }

  Future<bool> startListening({
    required void Function(String text) onResult,
    String localeId = 'ar_EG',
  }) async {
    if (!_isInitialized) {
      final initialized = await initialize();
      if (!initialized) {
        return false;
      }
    }

    if (_speechToText.isListening) {
      await stopListening();
    }

    try {
      _isListening = true;
      return await _speechToText.listen(
        onResult: (result) {
          final text = result.recognizedWords.trim();
          if (text.isNotEmpty) {
            onResult(text);
          }
        },
        listenFor: const Duration(minutes: 3),
        pauseFor: const Duration(seconds: 3),
        partialResults: true,
        localeId: localeId,
        cancelOnError: true,
      );
    } catch (_) {
      _isListening = false;
      return false;
    }
  }

  Future<void> stopListening() async {
    if (_speechToText.isListening) {
      await _speechToText.stop();
    }
    _isListening = false;
  }
}
