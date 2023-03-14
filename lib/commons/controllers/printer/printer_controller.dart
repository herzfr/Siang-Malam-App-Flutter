import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class PrinterController extends GetxController {
  // var log = Logger();
  var box = GetStorage().obs;
  final dropdownState = GlobalKey<FormFieldState>();
  var devices = <BluetoothDevice>[].obs;
  var deviceChoose = BluetoothDevice(null, null).obs;
  var menuItems = <DropdownMenuItem<BluetoothDevice>>[].obs;

  var isProgress = false.obs;
  var messages = "".obs;
  var isConnected = false.obs;

  // TEXT CONTROLLER
  var tfBranch = TextEditingController().obs;
  var tfAddress = TextEditingController().obs;
  var tfInfo = TextEditingController().obs;

  @override
  void onInit() async {
    // bluetoothIsConnected();
    super.onInit();

    // log.d(box.value.read('PDCN'));
    // log.d(box.value.read('PDCT'));
    // log.d(box.value.read('PDCA'));
    // log.d(box.value.read('PDCC'));
    deviceChoose.value =
        BluetoothDevice(box.value.read('PDCN'), box.value.read('PDCA'));

    await getDeviceBlue();
    await checkConnection();
    initPrintSetting();
    // log.d(isConnected.value);
  }

  getDeviceBlue() async {
    // log.d('get bluetooth device');
    devices.value = await AppStatic.printerThermalInstance.getBondedDevices();
    // for (var item in devices) {
    //   log.d(item.name);
    //   log.d(item.type);
    //   log.d(item.address);
    //   log.d(item.connected);
    // }

    // log.d(BlueThermalPrinter.CONNECTED);
    // log.d(BlueThermalPrinter.DISCONNECTED);
    // log.d(BlueThermalPrinter.DISCONNECT_REQUESTED);
    // log.d(BlueThermalPrinter.ERROR);
    // log.d(BlueThermalPrinter.STATE_BLE_ON);
    // log.d(BlueThermalPrinter.STATE_BLE_TURNING_OFF);
    // log.d(BlueThermalPrinter.STATE_BLE_TURNING_ON);
    // log.d(BlueThermalPrinter.STATE_OFF);
    // log.d(BlueThermalPrinter.STATE_ON);
    // log.d(BlueThermalPrinter.STATE_TURNING_OFF);
    // log.d(BlueThermalPrinter.STATE_TURNING_ON);
    // log.d(BlueThermalPrinter.instance);

    // ignore: curly_braces_in_flow_control_structures
    if (devices.isNotEmpty) {
      menuItems.add(DropdownMenuItem(
          child: const Text("Tidak ada device"),
          value: BluetoothDevice(null, null)));
      // devices.map((e) => {DropdownMenuItem(child: Text(e.name!), value: e)});
      for (var item in devices) {
        // log.d('nama : ${item.name}');
        menuItems.add(DropdownMenuItem(child: Text(item.name!), value: item));
      }
      // log.d(menuItems.value.length);
    }
  }

  initPrintSetting() {
    tfBranch.value.text = box.value.read('PRINT_BRANCH');
    tfAddress.value.text = box.value.read('PRINT_ADDRESS');
    tfInfo.value.text = box.value.read('PRINT_INFO');
  }

  // logger() {
  //   log.d(deviceChoose.value.name);
  //   log.d(deviceChoose.value.type);
  //   log.d(deviceChoose.value.address);
  //   log.d(deviceChoose.value.connected);
  // }

  connectedDevice() async {
    isProgress.value = true;
    if ((await AppStatic.printerThermalInstance.isAvailable)!) {
      AppStatic.printerThermalInstance.isConnected.then((value) => {
            // log.d(value),
            if (!value!)
              {
                AppStatic.printerThermalInstance
                    .connect(deviceChoose.value)
                    .then(
                      (value) => {isProgress.value = false, checkConnection()},
                    )
                    .onError((error, stackTrace) =>
                        {isProgress.value = false, checkConnection()})
              }
            else
              {
                isProgress.value = false,
                messages.value = "Device Sudah Terkoneksi",
                messages.refresh(),
              }
          });
    }
  }

  checkConnection() async {
    await checkConnection2();
    await checkConnectionMessage();
    // await checkIsConnected();
    // logger();
  }

  checkConnectionMessage() async {
    if ((await AppStatic.printerThermalInstance.isAvailable)!) {
      if ((await AppStatic.printerThermalInstance.isOn)!) {
        if ((await AppStatic.printerThermalInstance
            .isDeviceConnected(deviceChoose.value))!) {
          messages.value = "Device Terkoneksi";
          messages.refresh();
        } else {
          messages.value = "Device Tidak Koneksi!";
          messages.refresh();
        }
      } else {
        messages.value = "Bluetooth Thermal Mati!";
        messages.refresh();
      }
    } else {
      messages.value = "Bluetooth Thermal Tidak Tersedia!";
      messages.refresh();
    }
  }

  checkConnection2() async {
    try {
      if ((await AppStatic.printerThermalInstance.isAvailable)!) {
        if ((await AppStatic.printerThermalInstance.isOn)!) {
          if ((await AppStatic.printerThermalInstance
              .isDeviceConnected(deviceChoose.value))!) {
            box.value.write("isConnected", true);
            isConnected.value = true;
            return true;
          } else {
            box.value.write("isConnected", false);
            isConnected.value = false;
            return false;
          }
        } else {
          isConnected.value = false;
          return false;
        }
      } else {
        isConnected.value = false;
        return false;
      }
    } catch (e) {
      isConnected.value = false;
      return false;
    }
  }

  cutConnection() async {
    isProgress.value = true;
    try {
      await AppStatic.printerThermalInstance.disconnect();
      isProgress.value = false;
      checkConnection();
    } on PlatformException catch (e) {
      // log.d(e.code);
      isProgress.value = false;
      if (e.code == "disconnection_error") {
        messages.value = "Device sudah tidak aktif";
      }
    }
  }

  setPrimaryDevice() {
    box.value.write('PDCN', deviceChoose.value.name);
    box.value.write('PDCT', deviceChoose.value.type);
    box.value.write('PDCA', deviceChoose.value.address);
    box.value.write('PDCC', deviceChoose.value.connected);
  }

  saveSettingPrint() {
    box.value.write('PRINT_BRANCH', tfBranch.value.text);
    box.value.write('PRINT_ADDRESS', tfAddress.value.text);
    box.value.write('PRINT_INFO', tfInfo.value.text);
  }

  testPrint() async {
    try {
      await AppStatic.printerThermalInstance.printNewLine();
    } on PlatformException catch (e) {
      // log.d(e.code);
      if (e.code == "write_error") {
        messages.value = "Tidak Terkoneksi";
        Snackbar.show("Device Tidak Terkoneksi!",
            "Mohon periksa device kembali", mtRed600, mtGrey50);
      }
    }
  }

  @override
  void onClose() {
    super.onClose();
    setPrimaryDevice();
    saveSettingPrint();
  }
}
