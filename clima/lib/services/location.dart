import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.denied || permission != LocationPermission.deniedForever) {
          Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
          latitude = position.latitude;
          longitude = position.longitude;
        }
      }
    }
  }
}