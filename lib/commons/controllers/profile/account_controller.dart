import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siangmalam/commons/functions/orientations.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/models/user.dart';
import 'package:siangmalam/models/user/image_profile_request.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/user/user_service.dart';

/* Created By Dwi Sutrisno */

class AccountController extends GetxController {
  // var log = Logger();
  var imageUrl = ''.obs;
  var imagePath = ''.obs;
  var fileName = ''.obs;

  //Logout function
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      // Remove data for the 'user' key.
      AppStatic.userData = UserDto();
      await prefs.remove('user');
      Get.offAllNamed(RouteName.signInScreen);
    } catch (e) {
      Get.snackbar("Logout Failed", "Gagal Logout Dari Aplikasi");
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    Orientations.forcePortrait();
    setProfileImage();
    getProfileData();
  }

  @override
  void onClose() {
    Orientations.defaultOrientation();
    super.onClose();
  }

  setProfileImage() {
    var userData = AppStatic.userData;

    if (userData.picture != null) {
      imageUrl.value = userData.picture!;
    } else {
      imageUrl.value = '';
    }
  }

  saveImage(String imagePath, String imageName) async {
    var imageRequest = ImageProfileRequestDto(fileName: imageName, filePath: imagePath);

    var result = await UserService().changeUserImage(imageRequest);
    if (result) {
      imageUrl.value = AppStatic.userData.picture!;
    }
  }

  getProfileData() {
    UserService().getUserProfile(AppStatic.userData.id!);
  }
}
