class ArabicTextUtils {
  ArabicTextUtils._();

  static final RegExp _diacritics = RegExp(
    r'[\u0617-\u061A\u064B-\u065F\u0670\u06D6-\u06ED]',
  );

  static String removeDiacritics(String input) =>
      input.replaceAll(_diacritics, '');

  static String cleanSurahName(String name) {
    return removeDiacritics(name)
        .replaceAll('\u0671', 'ا')
        .replaceFirst(RegExp(r'^سورة\s*'), '')
        .trim();
  }

  static String normalize(String input) {
    return removeDiacritics(input.trim().toLowerCase())
        .replaceAll(RegExp('[إأآ]'), 'ا')
        .replaceAll('ى', 'ي')
        .replaceAll('ة', 'ه');
  }
}
