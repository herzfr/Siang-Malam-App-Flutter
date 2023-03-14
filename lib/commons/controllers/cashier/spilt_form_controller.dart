import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/controllers/cashier/orderlist_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/cashier/splitbill.dart';
import 'package:siangmalam/models/order/create-order-response.dart';
import 'package:siangmalam/services/cashier/cashier_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class SplitFormController extends GetxController {
  OrderListController orderListController = Get.find();
  // var log = Logger();
  var split = SplitBill().obs;
  var bills = <Bills>[].obs;
  var item = ItemsSplit().obs;

  var order = CreateOrderResponse().obs;
  var cartItem = <Cart>[].obs;

  // CONTROLLER
  final formKey = GlobalKey<FormState>();
  var textFieldNameController = TextEditingController().obs;
  var textFieldNoteController = TextEditingController().obs;

  @override
  void onInit() {
    // log.d("SplitFormController");
    super.onInit();
    order = orderListController.order;
    cartItem = orderListController.cartItem;
    split.value.tempSalesId = order.value.id;
    split.value.waiter = order.value.waiter;
    // log.d(order.toJson());
    // log.d(cartItem.toJson());
  }

  convertPrice(int? price) {
    if (price != null) {
      final currencyFormatter = NumberFormat('#,##0', 'ID');
      return 'Rp ' + currencyFormatter.format(price);
    } else {
      return 'Rp -';
    }
  }

  bool? validateName(String value) {
    if (value.isNotEmpty) {
      return true;
    }
    return false;
  }

  addBill() {
    if (validateName(textFieldNameController.value.text)!) {
      var bill = Bills();
      if (formKey.currentState!.validate()) {
        // log.d("value ada");
        bill.name = textFieldNameController.value.text;
        bill.note = textFieldNoteController.value.text;
        bills.add(bill);
        bills.refresh();

        // log.d(bills.toJson());
        textFieldNameController.value = TextEditingController();
        textFieldNoteController.value = TextEditingController();
      }
    } else {
      Snackbar.show(
          "Pisah Bill", "Oops nama tidak boleh kosong", mtRed600, mtGrey50);
    }
  }

  itemDroppedOnCustomerCart(Cart item, int index) {
    // log.d(item.toJson());
    // log.d(bills.elementAt(index).toJson());
    var split = ItemsSplit();
    split.id = item.id;
    split.menuId = item.menuId;
    split.name = item.name;
    split.amount = 1;

    if (!bills.elementAt(index).items.any((e) => e.id == split.id)) {
      bills.elementAt(index).items.add(split);
      cartItem.firstWhere((e) => e.id == split.id).amount =
          (cartItem.firstWhere((e) => e.id == split.id).amount! - 1);
      bills.refresh();
      cartItem.refresh();
    } else {
      bills.elementAt(index).items.firstWhere((e) => e.id == split.id).amount =
          (bills
                  .elementAt(index)
                  .items
                  .firstWhere((e) => e.id == split.id)
                  .amount! +
              1);
      cartItem.firstWhere((e) => e.id == split.id).amount =
          (cartItem.firstWhere((e) => e.id == split.id).amount! - 1);
      bills.refresh();
      cartItem.refresh();
    }
  }

  deleteBills(int index) {
    // log.d(bills.elementAt(index).items);
    for (var item in bills.elementAt(index).items) {
      // cartItem.firstWhere((e) => e.id == item.id).amount = item.amount;
      cartItem[cartItem.indexWhere((p0) => p0.id == item.id)].amount =
          (cartItem.firstWhere((e) => e.id == item.id).amount! + item.amount!);
    }
    bills.removeAt(index);
    bills.refresh();
    cartItem.refresh();
  }

  getNote() {
    if (bills.isEmpty) {
      return "Tambahkan minimal 2 nama bill terlebih dahulu";
    } else if (bills.length < 2) {
      return "Tambahkan 1 nama bill lagi";
    } else if (bills.length >= 2) {
      var contain = cartItem.where((e) => e.amount! > 0);
      if (contain.isNotEmpty) {
        return "Silahkan masukan item ke masing-masing bill, pastikan item 0 semua";
      } else {
        if (bills.any((p0) => p0.items.isEmpty)) {
          return "Beberapa nama bill masih ada yang kosong";
        } else {
          return "Silahkan tap tombol 'Pisahkan'";
        }
      }
    }
  }

  getAllowedSpill() {
    if (bills.isEmpty) {
      return false;
    } else if (bills.length < 2) {
      return false;
    } else if (bills.length >= 2) {
      var contain = cartItem.where((e) => e.amount! > 0);
      if (contain.isNotEmpty) {
        return false;
      } else {
        if (bills.any((p0) => p0.items.isEmpty)) {
          return false;
        } else {
          return true;
        }
      }
    }
  }

  onSubmitSplit() async {
    split.value.bills = bills;
    // log.d(split.toJson());
    await CashierService.splitBillService(split.value);
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  // }
}
