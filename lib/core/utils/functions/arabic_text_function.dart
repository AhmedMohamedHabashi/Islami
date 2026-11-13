bool _isIgnoredCharacter(int rune) {
  final isTashkeel =
      (rune >= 0x064B && rune <= 0x065F) ||
      rune == 0x0670 ||
      (rune >= 0x06D6 && rune <= 0x06ED);

  final isTatweel = rune == 0x0640;
  final isWhitespace = String.fromCharCode(rune).trim().isEmpty;

  return isTashkeel || isTatweel || isWhitespace;
}

String _normalizeArabicCharacter(int rune) {
  if (rune == 0x0671) return 'ا'; // ٱ
  if (rune == 0x06CC) return 'ي'; // ی

  return String.fromCharCode(rune);
}

int? _getBasmalaEndOffset(String text) {
  const basmala = 'بسماللهالرحمنالرحيم';

  var targetIndex = 0;
  var offset = 0;
  var matchedEnd = 0;

  for (final rune in text.runes) {
    final runeLength = rune > 0xFFFF ? 2 : 1;

    if (_isIgnoredCharacter(rune)) {
      offset += runeLength;
      continue;
    }

    if (targetIndex >= basmala.length ||
        _normalizeArabicCharacter(rune) != basmala[targetIndex]) {
      return null;
    }

    targetIndex++;
    offset += runeLength;
    matchedEnd = offset;

    if (targetIndex == basmala.length) break;
  }

  if (targetIndex != basmala.length) return null;

  // Remove spaces and diacritics immediately after Basmala.
  for (final rune in text.substring(matchedEnd).runes) {
    if (!_isIgnoredCharacter(rune)) break;

    matchedEnd += rune > 0xFFFF ? 2 : 1;
  }

  return matchedEnd;
}

bool startsWithBasmala(String text) {
  return _getBasmalaEndOffset(text) != null;
}

String removeLeadingBasmala(String text) {
  final endOffset = _getBasmalaEndOffset(text);

  if (endOffset == null) return text;

  return text.substring(endOffset);
}
