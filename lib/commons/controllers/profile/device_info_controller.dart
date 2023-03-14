import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/functions/orientations.dart';

/* Created By Dwi Sutrisno */
class DeviceInfoController extends GetxController {
  late TextEditingController deviceNameController = TextEditingController();
  late TextEditingController deviceVersionController = TextEditingController();
  late TextEditingController deviceIdController = TextEditingController();

  final deviceInfoPlugin = DeviceInfoPlugin();

  @override
  void onInit() {
    Orientations.forcePortrait();
    super.onInit();
    initDeviceInfo();
  }

  @override
  void onClose() {
    Orientations.defaultOrientation();
    super.onClose();
    deviceNameController.dispose();
    deviceVersionController.dispose();
    deviceIdController.dispose();
  }

  Future<void> initDeviceInfo() async {
    final deviceDetails = await getDeviceDetails();
    deviceNameController.text = deviceDetails[0];
    deviceVersionController.text = deviceDetails[1];
    deviceIdController.text = deviceDetails[2];
  }

  static Future<List<String>> getDeviceDetails() async {
    String deviceName = '';
    String deviceVersion = '';
    String identifier = '';
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    // final deviceInfo = await deviceInfoPlugin.deviceInfo;
    // final map = deviceInfo.toMap();
    // print(map);
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model ?? '';
        deviceVersion = build.version.release ?? '';
        identifier = build.id ?? '';
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name ?? '';
        deviceVersion = data.systemVersion ?? '';
        identifier = data.identifierForVendor ?? '';
      }
    } on PlatformException {
      // print('Failed to get platform version');
    }

    return [deviceName, deviceVersion, identifier];
  }
}
