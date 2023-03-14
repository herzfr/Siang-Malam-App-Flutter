import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/models/cashier/piggybank.dart';
import 'package:siangmalam/models/sub_branch.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/cashier/piggybank_service.dart';

class SavingController extends GetxController {
  // var log = Logger();
  var level = AppStatic.userData.level;
  late int? branchId = AppStatic.userData.branchId!;
  late int? subBranchId;

  final formKeyAmount = GlobalKey<FormState>();
  var textAmountController = TextEditingController(text: "0").obs;

  var setSubbranch = SubbranchSetSaving().obs;
  var setBranch = BranchSetSaving().obs;
  var resSaving = ResponsePiggyBank().obs;
  var savingMoney = PiggyBank().obs;

  var dDBranch = <DropdownMenuItem<int>>[].obs;

  var isCheckPiggy = false.obs;

  @override
  void onInit() async {
    super.onInit();
    await setBranchDropDown();
    await onGetPiggyBank();
  }

  onGetPiggyBank() async {
    await getSavingMoney();
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

  onBranch() {
    onGetPiggyBank();
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

  onChangeValueAmount(String value) {
    // log.d(main(convertStringToNumber(value)));
    savingMoney.value.savingAmount = main(convertStringToNumber(value));
    savingMoney.refresh();
  }

  converDateMillisToString(int millis) {
    var dt = DateTime.fromMillisecondsSinceEpoch(millis);
    return DateFormat('dd MMMM yyyy, HH:mm').format(dt).toString();
  }

  Future<void> setSavingMoney() async {
    if (subBranchId != null) {
      // log.d(true);
      setSubbranch.value.subBranchId = subBranchId;
      setSubbranch.value.amount = savingMoney.value.savingAmount;
      bool result = await PiggyBankService.setSaving(
          BranchSetSaving(), setSubbranch.value, false);
      // log.d(result);
      if (result) {
        onGetPiggyBank();
        textAmountController.value.clear();
      }
    } else {
      setBranch.value.branchId = branchId;
      setBranch.value.amount = savingMoney.value.savingAmount;
      bool result = await PiggyBankService.setSaving(
          setBranch.value, SubbranchSetSaving(), true);
      // log.d(result);
      if (result) {
        onGetPiggyBank();
        textAmountController.value.clear();
      }
    }
  }

  Future<void> getSavingMoney() async {
    isCheckPiggy.value = true;
    savingMoney.value =
        await PiggyBankService.getSavingMoneyInfo(subBranchId, branchId);
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  // }
}
