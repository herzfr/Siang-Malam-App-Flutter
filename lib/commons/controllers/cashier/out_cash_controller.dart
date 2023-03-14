import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/controllers/cashier/cashier_controller.dart';
import 'package:siangmalam/models/cashier/cashout.dart';
import 'package:siangmalam/models/cashier/shift.dart';
import 'package:siangmalam/models/user.dart';
import 'package:siangmalam/services/cashier/cashout_service.dart';
import 'package:siangmalam/services/user/user_service.dart';

class OutCashController extends GetxController {
  // var log = Logger();
  CashierController cashierController = Get.find();
  final formKeyAmount = GlobalKey<FormState>();

  int? branchId;
  int? subBranchId;

  var userDto = UserDto().obs;
  var userIdController = TextEditingController().obs;
  var textAmountController = TextEditingController(text: "0").obs;
  var shiftData = ShiftObj().obs;
  var cashout = CashOutEmpl().obs;

  var indexForm = 0.obs;

  @override
  void onInit() {
    shiftData.value = cashierController.shiftData.value;
    branchId = shiftData.value.branchid;
    subBranchId = shiftData.value.subBranchId;
    super.onInit();
  }

  changeForm(int i) {
    indexForm.value = i;
  }

  updateCashoutEmpl() {
    cashout.update((val) {
      val?.username = userDto.value.username;
      val?.amount =
          main(convertStringToNumber(textAmountController.value.text));
      val?.branchId = branchId;
      val?.subBranchId = subBranchId;
      val?.shiftId = shiftData.value.id;
    });
  }

  convertStringToNumber(String value) {
    var str = value.replaceAll(RegExp(r'[^0-9]'), '');
    return str;
  }

  updateEmplCashout() async {
    if (formKeyAmount.currentState!.validate()) {
      await updateCashoutEmpl();
      // log.d(cashout.toJson());
      await cashoutEmplPost();
    }
  }

  clearDataEmpl() {
    userDto.value = UserDto();
    userIdController.value = TextEditingController();
    textAmountController.value = TextEditingController(text: "0");
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

  onChangeValueAmount(String value) {
    // log.d(main(convertStringToNumber(value)));
    int amount = main(convertStringToNumber(value));
    int endCash = shiftData.value.endCash ?? 0;
    if (amount > endCash) {
      textAmountController.value.text = endCash.toString();
    }
  }

  Future<void> cashoutEmplPost() async {
    bool result = await CashoutService.cashoutEmpl(cashout.value);
    if (result) {
      shiftData.value.endCash =
          shiftData.value.endCash! - cashout.value.amount!;
      shiftData.refresh();
      clearDataEmpl();
      update();
    }
  }

  Future<void> fetchUserById(String id) async {
    userDto.value = UserDto();
    userDto.value = await UserService.getUserById(id);
    userDto.refresh();
    userIdController.value.clear();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
