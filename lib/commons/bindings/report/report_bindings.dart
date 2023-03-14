import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/report/reportbill_controller.dart';
import 'package:siangmalam/commons/controllers/report/reportcashbon_controller.dart';

class ReportBillBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ReportBillController());
  }
}

class ReportCashbonBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ReportCashbonController());
  }
}
