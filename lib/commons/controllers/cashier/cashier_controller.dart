import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
// import 'package:siangmalam/commons/controllers/cashier/invoice_controller.dart';
// import 'package:siangmalam/commons/controllers/cashier/orderlist_controller.dart';
import 'package:siangmalam/commons/functions/orientations.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/cashier/piggybank.dart';
import 'package:siangmalam/models/cashier/shift.dart';
import 'package:siangmalam/models/sub_branch.dart';
// import 'package:siangmalam/screens/home/pages/cashier/components/c_invoice_screen.dart';
// import 'package:siangmalam/screens/home/pages/cashier/components/c_order_screen.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/cashier/cashier_service.dart';
import 'package:siangmalam/services/cashier/piggybank_service.dart';

/* Created By Dwi Sutrisno */

class CashierController extends GetxController {
  // var log = Logger();
  late int? branchId = AppStatic.userData.branchId!;
  int? subBranchId;
  var level = AppStatic.userData.level;
  final deviceInfoPlugin = DeviceInfoPlugin();
  late Timer timer;
  var counter = "".obs;
  var setTimeTrigerSaving = "15:42";

  List<dynamic> itemsDrawer = [
    {
      "key": "Daftar Pesanan",
      "icons": Icons.shopping_cart_sharp,
      "route": RouteName.cashierOrderListScreen
    },
    // {
    //   "key": "Tagihan Gantung",
    //   "icons": Icons.list_alt,
    //   "route": RouteName.CashierInvoiceListScreen
    // },
    {
      "key": "Terjual",
      "icons": Icons.paid,
      "route": RouteName.cashierSalesScreen
    },
    {
      "key": "Keluarkan Uang Kasir",
      "icons": Icons.money_off_csred,
      "route": RouteName.outCashScreen
    },
    {
      "key": "Pengaturan",
      "icons": Icons.settings_applications,
      "route": RouteName.cashierSettingsScreen
    },
  ];

  List<IconData> icones = [
    Icons.shopping_cart_sharp,
    Icons.list_alt,
    Icons.paid,
    Icons.outbond,
    Icons.settings_applications,
  ];

  // DEVICE
  String? deviceName;
  String? deviceVersio;
  String? deviceIdController;

  var dDBranch = <DropdownMenuItem<int>>[].obs;

  final formKeyShift = GlobalKey<FormState>();
  var tStartCashController = TextEditingController().obs;
  var tStartCashOprationalController = TextEditingController().obs;
  var tAddCashController = TextEditingController().obs;

  // SHIFT
  // =================================
  var shiftData = ShiftObj().obs;
  var checkShift = CheckShift().obs;
  var getShift = GetShift().obs;
  var starShift = StartShift().obs;
  var stopShift = StopShift().obs;
  var updateCashShift = UpdateCashShift().obs;

  var savingMoney = PiggyBank().obs;

  var indexPage = 0.obs;
  var isCheckPiggy = false.obs;

  @override
  void onInit() async {
    // log.d('Cashier Controller init');
    Orientations.landscapeOrientation();
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => {refreshDate()});
    initDeviceInfo();
    await setBranchDropDown();
    super.onInit();
    tStartCashOprationalController.value.text = 0.toString();
    // log.d(shiftData.toJson());
    await checkShiftData();
    await getSavingMoney();
  }

  // DEVICE
  // =================================
  Future<void> initDeviceInfo() async {
    final deviceDetails = await getDeviceDetails();
    deviceName = deviceDetails[0];
    deviceVersio = deviceDetails[1];
    deviceIdController = deviceDetails[2];
    // log.d(deviceName);
    // log.d(deviceVersio);
    // log.d(deviceIdController);
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

  // GENERAL
  // =================================

  savingDateTime() {
    DateTime newDate = DateTime.now();
    DateTime formatedDate = newDate.subtract(Duration(
        hours: newDate.hour,
        minutes: newDate.minute,
        seconds: newDate.second,
        milliseconds: newDate.millisecond,
        microseconds: newDate.microsecond));
    // log.d(formatedDate);
    final DateFormat formatter = DateFormat('HH:mm');
    final String formatted = formatter.format(DateTime.now());
    // log.d(formatted);
    var isUpdate = formatted == setTimeTrigerSaving ? true : false;
    // log.d(isUpdate);
    var i = 0;
    if (isUpdate) {
      // getSavingMoney();
      i++;
      if (i == 1) {
        getSavingMoney();
      }
    }
  }

  setBranchDropDown() async {
    List<SubBranch>? dataSub = AppStatic.userData.subBranch;
    if (level == 'BRANCH') {
      dDBranch.add(DropdownMenuItem<int>(
          child: Text(AppStatic.userData.branch.toString()), value: null));
    }
    subBranchId = dataSub!.first.id;
    for (var item in dataSub) {
      dDBranch.add(DropdownMenuItem<int>(
          child: Text(item.name.toString()), value: item.id));
    }
  }

  refreshDate() {
    var dt = DateTime.now();
    counter.value = DateFormat('dd MMMM yyyy, HH:mm:ss').format(dt).toString();
    counter.refresh();
    // savingDateTime();
  }

  converDateMillisToString(int millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dt).toString();
  }

  convertPrice(int? price) {
    if (price != null) {
      final currencyFormatter = NumberFormat('#,##0', 'ID');
      return 'Rp ' + currencyFormatter.format(price);
    } else {
      return 'Rp 0';
    }
  }

  convertStringToNumber(String value) {
    var str = value.replaceAll(RegExp(r'[^0-9]'), '');
    return str;
  }

  int main(String arguments) {
    try {
      var str = arguments == '' ? (0).toString() : arguments;
      int? a = int.parse(str);
      return a.abs();
    } on FormatException {
      return 0;
    }
  }

  checkShiftData() async {
    await updateCheck(branchId, subBranchId);
    // log.d(checkShift.toJson());
    await fetchCheckShift();
    // log.d(shiftData.toJson());
  }

  startShiftNow() async {
    // log.d("message");
    // log.d(formKeyShift.currentState!.validate());
    if (formKeyShift.currentState!.validate()) {
      // log.d(main(convertStringToNumber(tStartCashController.value.text)));
      // log.d(tStartCashOprationalController.value.text);
      // log.d("message");
      await updateStart(
          subBranchId,
          main(convertStringToNumber(tStartCashController.value.text)),
          main(
              convertStringToNumber(tStartCashOprationalController.value.text)),
          deviceIdController);
      await postStartShift();
      tStartCashController.value.clear();
      tStartCashOprationalController.value.clear();
    }
  }

  updateCash() async {
    if (tAddCashController.value.text.isNotEmpty) {
      updateCashShift.update((val) {
        val?.id = shiftData.value.id;
        val?.amount =
            main(convertStringToNumber(tAddCashController.value.text));
        val?.deviceId = shiftData.value.deviceId;
      });
      var result = await CashierService.updateCashShift(updateCashShift.value);
      if (result) {
        tAddCashController.value.clear();
        checkShiftData();
      }
    } else {
      Get.snackbar("Error", "Mohon isi terlebih dahulu kolom penambahan cash",
          backgroundColor: mtRed600, colorText: textColor);
    }
  }

  endShiftNow() async {
    // await updateStart(subBranchId, );
    if (savingMoney.value.savingAmount == null) {
      await updateStop(shiftData.value.id);
      await postStoptShift();
      await checkShiftData();
    } else {
      Get.snackbar("Error", "Mohon Masukan Celengan Terlebih Dahulu",
          backgroundColor: mtRed600, colorText: textColor);
    }
  }
  // =================================
  // GENERAL

  // SHIFT UPDATE
  // =================================
  updateCheck(int? branchId, int? subBranchId) {
    checkShift.update((val) {
      val?.branchId = branchId;
      val?.subBranchId = subBranchId;
    });
  }

  updateStart(int? subBranchId, int? startCash, int? startOperationalCash,
      String? deviceId) async {
    starShift.update((val) {
      val?.startCash = startCash;
      val?.startOperationalCash = startOperationalCash;
      val?.subBranchId = subBranchId;
      val?.deviceId = deviceId;
    });
  }

  updateStop(int? id) {
    stopShift.update((val) {
      val?.id = id;
    });
  }

  addSavingMoney() async {
    // log.d(savingMoney.value.toJson());
    AddFilterPiggy addSaving = AddFilterPiggy();
    addSaving.amount = savingMoney.value.savingAmount;
    addSaving.shiftId = shiftData.value.id;
    addSaving.branchId = branchId;
    addSaving.subBranchId = subBranchId;
    // log.d(addSaving.toJson());
    bool ispiggyAdd = await PiggyBankService.addSavingMoney(addSaving);
    if (ispiggyAdd) {
      savingMoney.value = PiggyBank();
      savingMoney.refresh();
    }
  }

  checkPiggy() {
    getSavingMoney();
  }
  // =================================
  // SHIFT UPDATE

  // API
  // =================================
  Future<void> fetchCheckShift() async {
    shiftData.value = ShiftObj();
    shiftData.value = await CashierService.checkShift(checkShift.value);
    shiftData.refresh();
  }

  Future<void> postStartShift() async {
    shiftData.value = ShiftObj();
    shiftData.value = await CashierService.startShift(starShift.value);
    shiftData.refresh();
  }

  Future<void> postStoptShift() async {
    bool isStop = await CashierService.stopShift(stopShift.value);
    if (isStop) {
      shiftData.value = ShiftObj();
      shiftData.refresh();
    }
  }

  Future<void> getSavingMoney() async {
    isCheckPiggy.value = true;
    PiggyBank piggy =
        await PiggyBankService.getSavingMoneyInfo(subBranchId, branchId);
    DateTime timeNow = DateTime.now();
    DateTime date = DateTime.fromMillisecondsSinceEpoch(piggy.updatedAt!);
    // log.d(timeNow.difference(date).inHours);
    if (timeNow.difference(date).inDays > 0) {
      savingMoney.value = piggy;
      isCheckPiggy.value = false;
    }
    isCheckPiggy.value = false;
  }
  // =================================
  // API

  @override
  void onClose() {
    Orientations.defaultOrientation();
    super.onClose();
  }
}
