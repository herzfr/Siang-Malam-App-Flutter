import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/services/user/user_service.dart';

/* Created By Dwi Sutrisno */

class ChangePassController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController passwordInputController;
  late TextEditingController passwordVerifInputController;
  var obscureText = true.obs;
  var obscureVerifText = true.obs;
  var passIcon = null.obs;
  var passVerifIcon = null.obs;

  @override
  void onInit() {
    super.onInit();
    passwordInputController = TextEditingController();
    passwordVerifInputController = TextEditingController();
  }

  togglePass() {
    obscureText.value = !obscureText.value;
  }

  toggleVerifPass() {
    obscureVerifText.value = !obscureVerifText.value;
  }

  getPassIcon() {
    return obscureText.isTrue ? Icons.visibility_off : Icons.visibility;
  }

  getPassVerifIcon() {
    return obscureVerifText.isTrue ? Icons.visibility_off : Icons.visibility;
  }

  void submitPassword() {
    if (formKey.currentState!.validate()) {
      String password = passwordInputController.text;
      String passwordVerif = passwordVerifInputController.text;

      if (password == passwordVerif) {
        print("password same");

        var userService = UserService();
        userService.changeUserPassword(password, passwordVerif);
        
      } else {
        Get.snackbar("Kesalahan", "sandi dan verifikasi harus sama",
            backgroundColor: mtRed600, colorText: textColor);
      }
    }
  }
}
