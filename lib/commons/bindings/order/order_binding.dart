import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/order/order_controller.dart';
import 'package:siangmalam/commons/controllers/printer/printer_controller.dart';

/* Created By Herza Sutrisno */

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(OrderController());
  }
}
