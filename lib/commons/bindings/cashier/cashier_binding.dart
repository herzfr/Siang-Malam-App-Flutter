import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/cashier/cashier_controller.dart';
import 'package:siangmalam/commons/controllers/cashier/cashier_expense_controller.dart';
import 'package:siangmalam/commons/controllers/cashier/cashier_settings_controller.dart';
// import 'package:siangmalam/commons/controllers/cashier/invoice_controller.dart';
import 'package:siangmalam/commons/controllers/cashier/orderlist_controller.dart';
import 'package:siangmalam/commons/controllers/cashier/out_cash_controller.dart';
import 'package:siangmalam/commons/controllers/cashier/qrcode_controller.dart';
import 'package:siangmalam/commons/controllers/cashier/sales_controller.dart';
import 'package:siangmalam/commons/controllers/cashier/spilt_form_controller.dart';

/* Created By Dwi Sutrisno */

class CashierBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CashierController());
  }
}

class OrderListBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(OrderListController());
  }
}

class InvoiceListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InvoiceListBinding());
  }
}

class SplitFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplitFormController());
  }
}

class QrCodeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QrCodeController());
  }
}

class SalesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SalesController());
  }
}

class CashierSettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CashierSettingsController());
  }
}

class OutCashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(OutCashController());
  }
}

class CashierExpenseBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CashierExpenseController());
  }
}
