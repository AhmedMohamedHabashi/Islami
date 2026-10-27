import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart'; // 👈 أضف هذا الاستيراد
import 'package:islami/core/di/injection_container.config.dart';
import 'package:islami/core/network/api_constants.dart';
import 'package:islami/core/network/dio_factory.dart';

final sl = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // اسم دالة التهيئة الافتراضية
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> init() async {
  // 1. تسجيل الـ Dio يدوياً كما كنت تفعل
  sl.registerLazySingleton<Dio>(
    () => DioFactory.createDio(ApiConstants.prayerTimesBaseUrl),
    instanceName: 'prayerDio',
  );

  // 2. تفعيل توليد وحقن باقي الكلاسات (Repository و UseCases تلقائياً)
  await $initGetIt(sl);
}
