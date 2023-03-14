import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:siangmalam/commons/functions/debouncer.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/attendance/presence_check.dart';
import 'package:siangmalam/models/attendance/coordinate.dto.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/models/attendance/time_api.dart';
import 'package:siangmalam/commons/functions/general_util.dart';
import 'package:siangmalam/services/location/location_service.dart';
import 'package:siangmalam/services/attendance/attendance_service.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

/* Created By Dwi Sutrisno */

class AttendanceController extends GetxController {
  // var log = Logger();
  var currentTime = TimeApiDto().obs;
  var dayOfWeek = 'Senin'.obs;
  var hour = 0.obs;
  var minute = 0.obs;
  var dates = ''.obs;
  var street = ''.obs;
  var mapController = MapController().obs;
  var deviceCoordinate = AppStatic.currentDeviceLocation.obs;
  var distanceFrmWorkPlace = 0.0.obs;
  var buttonType = 'Masuk'.obs;
  late TextEditingController workNoteController = TextEditingController();
  var isCheckOut = false.obs;
  var workingHour = 0.obs;

  var debouncer = Debouncer(milliseconds: 1500);

  late Timer timer;

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    getCurrentTime();
    getAddressFromLatLong();
  }

  @override
  void onClose() {
    timer.cancel();
  }

  @override
  onReady() {
    super.onReady();

    var type = Get.arguments['type'];

    if (type == 1) {
      buttonType.value = 'Masuk';
      isCheckOut.value = false;
    } else {
      buttonType.value = 'Pulang';
      isCheckOut.value = true;
      workingHour.value = calculateWorkingHour();
      getPresenceStatus();
    }

    refreshInterval();
  }

  refreshInterval() {
    timer = Timer.periodic(const Duration(minutes: 1), (_) {
      getCurrentLocation();
    });
  }

  /* Get PresenceStatus Id Function */
  getPresenceStatus() {
    AttendanceService().getPresenceId();
  }

  /* Get Device location */
  getCurrentLocation() async {
    var response = await LocationService.locationPermission();
    deviceCoordinate.value = AppStatic.currentDeviceLocation;

    if (response) {
      var location = await LocationService().getCurrentDeviceLocation();
      deviceCoordinate.value = CoordinateDto(latitude: location.latitude, longitude: location.longitude);
      getAddressFromLatLong();
      getCurrentTime();
      mapController.value.move(LatLng(deviceCoordinate.value.latitude!, deviceCoordinate.value.longitude!), 18);
      getDistance();
    }
  }

  /*Get Current Time Function*/
  getCurrentTime() async {
    currentTime.value =
        await AttendanceService().getTime(AppStatic.currentDeviceLocation).then((value) => value).catchError((error) {
      var data = TimeApiDto();
      DateTime date = DateTime.now();
      data.date = '${date.day}/${date.month}/${date.year}';
      data.hour = date.hour;
      data.minute = date.minute;
      data.dayOfWeek = GeneralUtils().dayOfweeks(date.weekday);
      return data;
    });

    dayOfWeek.value = GeneralUtils().dayOfweekToInd(currentTime.value.dayOfWeek!);
    hour.value = currentTime.value.hour!;
    minute.value = currentTime.value.minute!;
    dates.value = currentTime.value.date!;
  }

  Future<void> getAddressFromLatLong() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      AppStatic.currentDeviceLocation.latitude!,
      AppStatic.currentDeviceLocation.longitude!,
    );
    Placemark place = placemarks[0];
    street.value = place.street!;
  }

  //get device and workplace distance
  getDistance() {
    double workPlaceLat = AppStatic.workPlaceLocation.latitude!;
    double workPlaceLon = AppStatic.workPlaceLocation.longitude!;
    double deviceLat = deviceCoordinate.value.latitude!;
    double deviceLon = deviceCoordinate.value.longitude!;

    double distanceInMeters = Geolocator.distanceBetween(workPlaceLat, workPlaceLon, deviceLat, deviceLon);
    distanceFrmWorkPlace.value = distanceInMeters;
  }

  //user checkin submit function
  userCheckIn() async {
    var timeResponse = await AttendanceService().getTime(AppStatic.currentDeviceLocation);

    if (timeResponse.dateTime != null) {
      PresenceCheckDto checkInData = PresenceCheckDto();
      checkInData.distance = distanceFrmWorkPlace.value.toInt();
      checkInData.latitude = deviceCoordinate.value.latitude.toString();
      checkInData.longitude = deviceCoordinate.value.longitude.toString();
      checkInData.note = '';
      checkInData.location = street.value;

      debouncer.runWithDelay(
        1500,
        () async {
          var presenceResponse = await AttendanceService().checkInPresence(checkInData);
          if (presenceResponse.id != null) {
            AppStatic.userPresenceStatus.isHashCheckIn = true;
          }
        },
      );
    } else {
      Snackbar.show("Error", "Gagal sinkronisasi waktu", mtRed600, textColor);
    }
  }

  //user checkout submit function
  userCheckOut() async {
    // var checkInTime = AppStatic.userPresenceStatus.checkInTime ?? DateTime.now().millisecondsSinceEpoch;
    // var checkOutDateTimeVal = currentTime.value.dateTime ?? DateTime.now().toIso8601String();
    // var checkOutTime = GeneralUtils().convertStringToDate(checkOutDateTimeVal) ?? DateTime.now();
    // DateTime checkInDateTime = DateTime.fromMillisecondsSinceEpoch(checkInTime);
    // DateTime checkOutDateTime = checkOutTime;
    workingHour.value = calculateWorkingHour();

    Get.defaultDialog(
      title: "Keterangan Kerja",
      // middleText: "Hello world!",
      backgroundColor: Colors.white,
      titleStyle: const TextStyle(color: mtGrey700),
      middleTextStyle: const TextStyle(color: primaryYellow),
      textConfirm: "Ok",
      textCancel: "Batal",
      cancelTextColor: mtGrey700,
      confirmTextColor: mtGrey700,
      buttonColor: primaryYellow,
      barrierDismissible: false,
      radius: 10,
      content: Column(
        children: [
          CustomInputFieldWONode(
            controller: workNoteController,
            hint: "",
            label: '',
            enable: true,
            icon: Icons.edit,
            inputType: TextInputType.multiline,
            dataInstance: (String? val) {},
            validationBuilder: (_) {
              return null;
            },
            lineNumbers: 3,
            maxlines: 50,
          )
        ],
      ),
      onConfirm: () {
        Get.back();
        var noteValue = workNoteController.text.toString();

        // if (timeResponse.dateTime != null) {
        PresenceCheckDto checkOutData = PresenceCheckDto();
        checkOutData.presenceId = AppStatic.presenceId;
        checkOutData.distance = distanceFrmWorkPlace.value.toInt();
        checkOutData.latitude = deviceCoordinate.value.latitude.toString();
        checkOutData.longitude = deviceCoordinate.value.longitude.toString();
        checkOutData.note = workNoteController.text.toString();
        checkOutData.location = street.value;
        checkOutData.workingTimes = calculateWorkingMinute();

        // print("presence data ${checkOutData.toString()}");

        debouncer.runWithDelay(
          1500,
          () async {
            bool isSuccess = await AttendanceService().checkOutPresence(checkOutData);
            if (isSuccess) {
              AppStatic.userPresenceStatus.isHasCheckout = true;
              Snackbar.showAndBack("Berhasil", "Absensi anda sudah tercatat", mtBlue300, textColor);
            }
          },
        );
      },
    );
  }

  calculateWorkingHour() {
    var checkInTime = AppStatic.userPresenceStatus.checkInTime ?? DateTime.now().millisecondsSinceEpoch;
    var checkOutDateTimeVal = currentTime.value.dateTime ?? DateTime.now().toIso8601String();
    var checkOutTime = GeneralUtils().convertStringToDate(checkOutDateTimeVal) ?? DateTime.now();
    DateTime checkInDateTime = DateTime.fromMillisecondsSinceEpoch(checkInTime);
    DateTime checkOutDateTime = checkOutTime;
    var workingHours = GeneralUtils().getDurationInHours(checkInDateTime, checkOutDateTime);
    return workingHours;
  }

  calculateWorkingMinute() {
    var checkInTime = AppStatic.userPresenceStatus.checkInTime ?? DateTime.now().millisecondsSinceEpoch;
    var checkOutDateTimeVal = currentTime.value.dateTime ?? DateTime.now().toIso8601String();
    var checkOutTime = GeneralUtils().convertStringToDate(checkOutDateTimeVal) ?? DateTime.now();
    DateTime checkInDateTime = DateTime.fromMillisecondsSinceEpoch(checkInTime);
    DateTime checkOutDateTime = checkOutTime;
    var workingMinutes = GeneralUtils().getDurationInMinutes(checkInDateTime, checkOutDateTime);
    return workingMinutes;
  }

  /* On Check Button Submit Function */
  checkButtonSubmit() {
    var type = Get.arguments['type'];
    if (type == 1) {
      if (distanceFrmWorkPlace.value > AppStatic.workPlaceLocation.distanceTolerance!) {
        Snackbar.show('Peringatan', "jarak anda terlalu jauh dari lokasi kerja", mtRed600, textColor);
      } else {
        userCheckIn();
      }
    } else {
      if (distanceFrmWorkPlace.value > AppStatic.workPlaceLocation.distanceTolerance!) {
        Snackbar.show('Peringatan', "jarak anda terlalu jauh dari lokasi kerja", mtRed600, textColor);
      } else {
        // userCheckIn();
        userCheckOut();
      }
    }
  }
}
