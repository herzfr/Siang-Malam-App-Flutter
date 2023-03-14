import 'package:get/get.dart';

class DashboardController extends GetxController {
  var tabIndex = 0;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  changeIndex(int index) {
    tabIndex = index;
    update();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }
}
