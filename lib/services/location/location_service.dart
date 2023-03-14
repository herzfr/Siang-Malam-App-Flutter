import 'package:geolocator/geolocator.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/widgets/snack_bar.dart';
import 'package:siangmalam/models/attendance/coordinate.dto.dart';

/* Created By Dwi Sutrisno */

class LocationService {
  /* Get Location Permission Function */
  static Future<bool> locationPermission() async {
    LocationPermission permission;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Snackbar.showWithTime(
        "Error",
        "Mohon aktifkan gps",
        mtRed600,
        textColor,
        5,
      );
      Future.delayed(
        const Duration(seconds: 5),
        () {
          Geolocator.openLocationSettings();
        },
      );
      return false;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Snackbar.showWithTime("Error", "Mohon izinkan akses lokasi", mtRed600, textColor, 5);
        locationPermission();
      }
      return false;
    }

    if (permission == LocationPermission.deniedForever) {
      Snackbar.showWithTime(
        "Error",
        "Mohon izinkan akses lokasi",
        mtRed600,
        textColor,
        5,
      );
      Future.delayed(
        const Duration(seconds: 5),
        () {
          Geolocator.openAppSettings();
          // openAppSettings();
        },
      );
      return false;
    }

    return true;
  }

  /* Get CurrentDevice Location Function */
  Future<CoordinateDto> getCurrentDeviceLocation() async {
    var position = await GeolocatorPlatform.instance.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.best),
    );

    AppStatic.currentDeviceLocation.latitude = position.latitude;
    AppStatic.currentDeviceLocation.longitude = position.longitude;

    return AppStatic.currentDeviceLocation;
  }
}
