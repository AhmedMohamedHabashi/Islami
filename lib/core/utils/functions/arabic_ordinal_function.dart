class ArabicOrdinalFunction {
  static String getOrdinal(int n) {
    if (n == 1) return 'الأول';
    if (n == 2) return 'الثاني';

    const ones = [
      '',
      'الأول',
      'الثاني',
      'الثالث',
      'الرابع',
      'الخامس',
      'السادس',
      'السابع',
      'الثامن',
      'التاسع',
    ];
    const teens = [
      'العاشر',
      'الحادي عشر',
      'الثاني عشر',
      'الثالث عشر',
      'الرابع عشر',
      'الخامس عشر',
      'السادس عشر',
      'السابع عشر',
      'الثامن عشر',
      'التاسع عشر',
    ];
    const tens = [
      '',
      '',
      'العشرون',
      'الثلاثون',
      'الأربعون',
      'الخمسون',
      'الستون',
      'السابعون',
      'الثمانون',
      'التسعون',
    ];

    if (n < 10) return ones[n];
    if (n < 20) return teens[n - 10];

    if (n <= 99) {
      int t = n ~/ 10;
      int u = n % 10;
      if (u == 0) {
        return tens[t]; // هتطلع: الثلاثون، الأربعون، إلخ بشكل صحيح تماماً
      } else {
        // للرقم مثل 31: الحادي والثلاثون
        String unitWord = ones[u];
        if (u == 1) unitWord = 'الحادي';
        if (u == 2) unitWord = 'الثاني';
        return '$unitWord و${tens[t]}';
      }
    }

    if (n == 100) return 'المائة';

    return '$n';
  }
}
