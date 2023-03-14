import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/models/user.dart';
import 'package:siangmalam/services/auth/auth_service.dart';
import 'package:siangmalam/services/location/location_service.dart';
/* Created By Dwi Sutrisno */

class SplashController extends GetxController {
  var statusTxt = 'Loading...'.obs;
  // var log = Logger();
  @override
  void onInit() {
    super.onInit();
    delayRun(2, 'Check location....', getPermission());
  }

  checkAppData() async {
    UserDto? user = await AuthService.getUserData();

    if (user != null) {
      // print("user not null");
      bool response = await delayRun(
        2,
        'Connecting to network...',
        getUserData(),
      );

      if (response) {
        toDashboardScreen();
      } else {
        toSignInScreen();
      }
    } else {
      toSignInScreen();
    }
  }

  getUserData() async {
    bool response = await AuthService.sendRefresh();
    return response;
  }

  delayRun(int delay, String message, dynamic func) {
    statusTxt.value = message;
    return Future.delayed(Duration(seconds: delay), () {
      statusTxt.value = message;
      return func;
    });
  }

  void toSignInScreen() {
    statusTxt.value = 'Loading...';
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(RouteName.signInScreen);
    });
  }

  // void toHomeScreen() {
  //   statusTxt.value = 'Loading...';
  //   Future.delayed(const Duration(seconds: 2), () {
  //     Get.offNamed(RouteName.home);
  //   });
  // }

  void toDashboardScreen() {
    statusTxt.value = 'Loading...';
    Future.delayed(const Duration(seconds: 2), () {
      Get.offNamed(RouteName.dashboardScreen);
    });
  }

  getPermission() async {
    bool permissionStatus = await LocationService.locationPermission();
    if (permissionStatus) {
      await LocationService().getCurrentDeviceLocation();
      delayRun(2, 'Get user data...', checkAppData());
    } else {
      getPermission();
    }
  }
}
