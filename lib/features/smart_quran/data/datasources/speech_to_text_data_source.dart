import 'package:injectable/injectable.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

@lazySingleton
class SpeechToTextDataSource {
  final stt.SpeechToText _speechToText = stt.SpeechToText();

  bool _isInitialized = false;

  bool get isListening => _speechToText.isListening;

  bool get isAvailable => _speechToText.isAvailable;

  bool get isInitialized => _isInitialized;

  Future<bool> initialize({
    void Function(String status)? onStatus,
    void Function(String error)? onError,
  }) async {
    if (_isInitialized && _speechToText.isAvailable) {
      return true;
    }

    try {
      _isInitialized = await _speechToText.initialize(
        onStatus: onStatus,
        onError: (error) {
          onError?.call(error.errorMsg);
        },
      );

      return _isInitialized;
    } catch (_) {
      _isInitialized = false;
      return false;
    }
  }

  Future<List<stt.LocaleName>> getAvailableLocales() async {
    if (!_isInitialized || !_speechToText.isAvailable) {
      throw StateError('Speech recognition is not initialized');
    }

    return _speechToText.locales();
  }

  Future<stt.LocaleName?> getArabicLocale() async {
    final locales = await getAvailableLocales();

    for (final locale in locales) {
      if (locale.localeId == 'ar_EG' ||
          locale.localeId.toLowerCase() == 'ar-eg') {
        return locale;
      }
    }

    for (final locale in locales) {
      if (locale.localeId.toLowerCase().startsWith('ar')) {
        return locale;
      }
    }

    return null;
  }

  Future<void> startListening({
    required String localeId,
    required void Function(String text, bool isFinal) onResult,
  }) async {
    if (!_isInitialized || !_speechToText.isAvailable) {
      throw StateError('Speech recognition is not available');
    }

    if (_speechToText.isListening) {
      await _speechToText.stop();
    }

    await _speechToText.listen(
      onResult: (result) {
        final text = result.recognizedWords.trim();

        if (text.isNotEmpty) {
          onResult(text, result.finalResult);
        }
      },
      listenOptions: stt.SpeechListenOptions(
        localeId: localeId,
        partialResults: true,
        cancelOnError: false,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 3),
      ),
    );
  }

  Future<void> stopListening() async {
    if (_speechToText.isListening) {
      await _speechToText.stop();
    }
  }

  Future<void> cancelListening() async {
    if (_speechToText.isListening) {
      await _speechToText.cancel();
    }
  }
}
