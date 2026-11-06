import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocationService {
  Future<Map<String, double>> getCurrentCoordinates() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return {'latitude': 31.2001, 'longitude': 29.9187};
      }

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

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      return {'latitude': position.latitude, 'longitude': position.longitude};
    } catch (e) {
      print("========== 🔴 LOCATION ERROR: $e ==========");
    }

    return {'latitude': 31.2001, 'longitude': 29.9187};
  }
}
