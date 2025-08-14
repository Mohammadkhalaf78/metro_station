import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

// بيانات المحطات (أنت هتحط بياناتك الكاملة هنا)
final List<Map<String, dynamic>> stationsList = [
  {"name": "Sadat", "lat": 30.0444, "lng": 31.2357},
  {"name": "Dokki", "lat": 30.0381, "lng": 31.2118},
  {"name": "Helwan", "lat": 29.8492, "lng": 31.3342},
];

// Controller
class NearestStationController extends GetxController {
  var placeName = "".obs;
  var nearestStation = RxnString();

  // تحويل العنوان لإحداثيات
  Future<Position?> _getLatLngFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return Position(
          latitude: locations.first.latitude,
          longitude: locations.first.longitude,
          timestamp: DateTime.now(),
          accuracy: 1,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0,
          altitudeAccuracy: 1,
          headingAccuracy: 1,
        );
      }
    } catch (e) {
      print("Error: $e");
    }
    return null;
  }

  // حساب أقرب محطة
  String? _getNearestStation(double lat, double lng) {
    double shortestDistance = double.infinity;
    String? nearest;

    for (var station in stationsList) {
      double distance = Geolocator.distanceBetween(
        lat,
        lng,
        station['lat'],
        station['lng'],
      );
      if (distance < shortestDistance) {
        shortestDistance = distance;
        nearest = station['name'];
      }
    }
    return nearest;
  }

  // البحث عن المحطة الأقرب من اسم المكان
  Future<void> findNearestStation() async {
    if (placeName.value.trim().isEmpty) {
      Get.snackbar("Error", "Please enter a place name");
      return;
    }

    Position? pos = await _getLatLngFromAddress(placeName.value);
    if (pos != null) {
      nearestStation.value =
          _getNearestStation(pos.latitude, pos.longitude);
    }
  }
}
