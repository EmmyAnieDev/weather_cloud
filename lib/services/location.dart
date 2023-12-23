import 'package:geolocator/geolocator.dart';

class Location {
  double? longitude;
  double? latitude;
  Future<void> getCurrentLocation() async {
    try {
      // get location's position using it lat and lon
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      longitude = position.longitude;
      latitude = position.latitude;
    } catch (e) {
      // print('geolocator Issue');
      // print(e);
    }
  }
}
