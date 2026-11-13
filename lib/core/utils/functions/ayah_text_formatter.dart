import 'package:islami/core/utils/functions/arabic_text_function.dart';
import 'package:islami/features/smart_quran/domain/entities/ayah.dart';

class AyahTextFormatter {
  AyahTextFormatter._();

  static String formatAyahs({
    required List<Ayah> ayahs,
    required bool showBasmala,
  }) {
    final buffer = StringBuffer();

    for (int i = 0; i < ayahs.length; i++) {
      var text = ayahs[i].text.trim();

      if (i == 0 && showBasmala) {
        text = removeLeadingBasmala(text);
      }

      if (text.isEmpty) continue;

      buffer.write('﴿${_toArabicDigits(ayahs[i].numberInSurah)}﴾ ');
      buffer.write(text);
      buffer.write(' ');
    }

    return buffer.toString().trim();
  }

  static String _toArabicDigits(int number) {
    const digits = '٠١٢٣٤٥٦٧٨٩';

    return number.toString().split('').map((digit) {
      return digits[int.parse(digit)];
    }).join();
  }
}
