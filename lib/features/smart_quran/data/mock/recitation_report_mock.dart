import '../../domain/entities/recitation_report.dart';

const RecitationReport mockRecitationReport = RecitationReport(
  surahName: 'سورة الكهف',
  startAyah: 1,
  endAyah: 2,

  ayahs: [
    RecitationAyah(
      ayahNumber: 1,
      words: [
        RecitationWord(id: 1, text: 'الْحَمْدُ'),
        RecitationWord(id: 2, text: 'لِلَّهِ'),
        RecitationWord(id: 3, text: 'الَّذِي'),
        RecitationWord(id: 4, text: 'أَنزَلَ'),
        RecitationWord(id: 5, text: 'عَلَىٰ'),
        RecitationWord(id: 6, text: 'عَبْدِهِ'),
        RecitationWord(id: 7, text: 'الْكِتَابَ'),
        RecitationWord(id: 8, text: 'وَلَمْ'),
        RecitationWord(id: 9, text: 'يَجْعَل'),
        RecitationWord(id: 10, text: 'لَّهُ'),
        RecitationWord(
          id: 11,
          text: 'عِوَجًا',
          status: RecitationWordStatus.warning,
        ),
      ],
    ),

    RecitationAyah(
      ayahNumber: 2,
      words: [
        RecitationWord(id: 12, text: 'قَيِّمًا'),
        RecitationWord(id: 13, text: 'لِّيُنذِرَ'),
        RecitationWord(id: 14, text: 'بَأْسًا'),
        RecitationWord(id: 15, text: 'شَدِيدًا'),
        RecitationWord(id: 16, text: 'مِّن'),
        RecitationWord(id: 17, text: 'لَّدُنْهُ'),
        RecitationWord(id: 18, text: 'وَيُبَشِّرَ'),
        RecitationWord(id: 19, text: 'الْمُؤْمِنِينَ'),
      ],
    ),
  ],

  alerts: [
    RecitationWordAlert(
      wordId: 11,
      ayahNumber: 1,
      ruleName: 'السكت',
      correctText: 'عِوَجًا',
      correctHint: 'سكتة لطيفة',
      recordedText: 'عِوَجَنْ قِيِّمًا',
    ),
  ],

  guidance: [
    RecitationGuidance(
      type: RecitationGuidanceType.tajweedRule,
      title: 'حكم السكت الواجب عند حفص عن عاصم',
      description:
          'عند الوصل بين الآيتين (١ و ٢)، يوجد سكت لطيف بلا تنفس على '
          'ألف "عوجا" دون استئناف "قيّما" لمنع توهم أن قيما صفة لعوجا.',
    ),
    RecitationGuidance(
      type: RecitationGuidanceType.repetitionSchedule,
      title: 'جدول التكرار الذكي الموصى به',
      description:
          'وفقًا لمنحنى النسيان، سيعاد اختبارك في الآيات (١-٥) بعد ٤٨ '
          'ساعة للحفاظ على نسبة الإتقان ٩٤٪ أو فوق.',
    ),
  ],
);
