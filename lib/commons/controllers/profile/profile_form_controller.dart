import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/functions/orientations.dart';
import 'package:siangmalam/models/user/user_profile.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/user/user_service.dart';

class ProfileFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  late TextEditingController firstNameController = TextEditingController();
  late TextEditingController lastNameController = TextEditingController();
  late TextEditingController address1Controller = TextEditingController();
  late TextEditingController address2Controller = TextEditingController();
  late TextEditingController address3Controller = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  var genderValue = true.obs;

  var firstName = '';
  var lastName = '';

  @override
  void onInit() {
    Orientations.forcePortrait();
    super.onInit();
    firstNameController.text = AppStatic.userProfile.firstName ?? '';
    lastNameController.text = AppStatic.userProfile.lastName ?? '';
    address1Controller.text = AppStatic.userProfile.address1 ?? '';
    address2Controller.text = AppStatic.userProfile.address2 ?? '';
    address3Controller.text = AppStatic.userProfile.address3 ?? '';
    phoneController.text = AppStatic.userProfile.phone ?? '';
    emailController.text = AppStatic.userProfile.email ?? '';
    genderValue.value = AppStatic.userProfile.gender!;
  }

  @override
  void onClose() {
    Orientations.defaultOrientation();
    super.onClose();
    firstNameController.dispose();
    lastNameController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    address3Controller.dispose();
    phoneController.dispose();
    emailController.dispose();
  }

  void setGender(value) {
    genderValue.value = value;
  }

  void submitProfile() {
    if (formKey.currentState!.validate()) {
      UserProfileDto userProfileDto = UserProfileDto();

      userProfileDto.userId = AppStatic.userProfile.userId;
      userProfileDto.firstName = firstNameController.text.toString();
      userProfileDto.lastName = lastNameController.text.toString();
      userProfileDto.address1 = address1Controller.text.toString();
      userProfileDto.address2 = address2Controller.text.toString();
      userProfileDto.address3 = address3Controller.text.toString();
      userProfileDto.gender = genderValue.value;
      userProfileDto.phone = phoneController.text.toString();
      userProfileDto.email = emailController.text.toString();

      UserService().updateUserProfile(userProfileDto);
    }
  }
}
