class AzkarCategoryEntity {
  final String
  id; // المعرف الفريد للتصنيف (عشان نعرف المستخدم داس على أنهي قسم)
  final String title; // اسم القسم (مثال: أذكار الصباح، أذكار المساء)
  final String iconPath; // مسار الأيقونة أو الصورة الخاصة بالقسم

  const AzkarCategoryEntity({
    required this.id,
    required this.title,
    required this.iconPath,
  });
}
