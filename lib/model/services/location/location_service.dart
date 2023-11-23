import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  late String address;
  Position? currentPosition;

  loadData(prevAddress) {
    address = prevAddress;
  }

  Future<bool> handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Geolocator.openLocationSettings();
      if (!serviceEnabled) {
        return false;
      }
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  Future getCurrentPosition() async {
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) return null;
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future getAddressFromPosition() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentPosition!.latitude, currentPosition!.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      address = "${place.street}, ${place.locality}, ${place.country}";
    }
    return null;
  }

  Future fetchLocation() async {
    await getCurrentPosition();
    await getAddressFromPosition();
  }
}
