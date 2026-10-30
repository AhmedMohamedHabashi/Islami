import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@lazySingleton // 2. تعريفه عشان الـ DI يشوفه
class LocationService {
  Future<Map<String, double>> getCurrentCoordinates() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      // 1. التأكد هل الـ GPS مفتوح في الموبايل
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return {
          'latitude': 31.2001,
          'longitude': 29.9187,
        }; // القاهرة افتراضياً أماناً
      }

      // 2. فحص الصلاحيات
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return {'latitude': 31.2001, 'longitude': 29.9187};
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return {'latitude': 31.2001, 'longitude': 29.9187};
      }

      // 3. جلب الإحداثيات الحالية بدقة
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return {'latitude': position.latitude, 'longitude': position.longitude};
    } catch (e) {
      print("========== 🔴 LOCATION ERROR: $e ==========");
    }

    // لو حصل أي خطأ، بنرجع إحداثيات القاهرة كقيمة افتراضية عشان التطبيق ما يضربش
    return {'latitude': 31.2001, 'longitude': 29.9187};
  }
}
