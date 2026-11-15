import 'package:flutter/material.dart';
import 'package:islami/core/shared/widgets/dialogs/custom_info_dialog.dart';
import 'package:islami/features/smart_quran/data/datasources/speech_to_text_data_source.dart';

class RecitationSpeechTest {
  static final SpeechToTextDataSource _speechDataSource =
      SpeechToTextDataSource();

  static Future<void> run(BuildContext context) async {
    final isInitialized = await _speechDataSource.initialize(
      onStatus: (status) {
        debugPrint('Speech Status: $status');
      },
      onError: (error) {
        debugPrint('Speech Error: $error');
      },
    );

    if (!context.mounted) return;

    if (!isInitialized) {
      _showMessage(
        context,
        title: 'التعرف على الكلام غير متاح',
        message: 'خدمة التعرف على الكلام غير متاحة حاليًا على جهازك.',
      );
      return;
    }

    try {
      final locales = await _speechDataSource.getAvailableLocales();

      debugPrint('========== AVAILABLE LOCALES ==========');

      for (final locale in locales) {
        debugPrint('${locale.localeId} - ${locale.name}');
      }

      debugPrint('=======================================');
      debugPrint('Trying Arabic locale: ar_EG');

      await _speechDataSource.startListening(
        localeId: 'ar_EG',
        onResult: (text, isFinal) {
          debugPrint('Arabic recognized: $text');
          debugPrint('Is final: $isFinal');
        },
      );
    } catch (e) {
      debugPrint('Arabic recognition failed: $e');

      if (!context.mounted) return;

      _showMessage(
        context,
        title: 'حدث خطأ',
        message: 'تعذر تشغيل التعرف على الكلام. حاول مرة أخرى.',
      );
    }
  }

  static void _showMessage(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    showDialog<void>(
      context: context,
      builder: (_) => CustomInfoDialog(title: title, message: message),
    );
  }
}
