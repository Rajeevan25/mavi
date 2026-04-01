import 'package:geolocator/geolocator.dart';

class LocationUtils {
  /// Checks if location services are enabled and permissions are granted.
  /// Then gets the current position.
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      throw Exception('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale 
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        throw Exception('Location permissions are denied');
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately. 
      throw Exception(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  /// Calculates the distance in meters between two geographical points.
  static double calculateDistance(
      double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  /// Checks if the current location is within a given radius of a target location.
  /// Default radius is 200 meters.
  ///
  /// NOTE: In this MOCK/demo build, GPS is simulated instantly to avoid
  /// browser permission delays. Switch to the real implementation below
  /// when deploying to production mobile.
  static Future<bool> isWithinGeofence(
      double targetLat, double targetLng, {double radiusInMeters = 200}) async {
    // ── MOCK: instant simulated GPS check ──────────────────────────────────
    await Future.delayed(const Duration(milliseconds: 50)); // tiny realistic pause
    return true; // always "within geofence" in the demo
    // ── END MOCK ────────────────────────────────────────────────────────────

    // ── REAL implementation (uncomment for production mobile) ──────────────
    // try {
    //   Position position = await getCurrentLocation();
    //   double distance = calculateDistance(
    //       position.latitude, position.longitude, targetLat, targetLng);
    //   return distance <= radiusInMeters;
    // } catch (e) {
    //   return false;
    // }
    // ── END REAL ────────────────────────────────────────────────────────────
  }
}
