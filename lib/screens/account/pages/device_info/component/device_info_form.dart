// class ProfileForm extends StatelessWidget {
import 'package:flutter/material.dart';
import 'package:siangmalam/commons/controllers/profile/device_info_controller.dart';
import 'package:siangmalam/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:siangmalam/constans/form_values.dart';
import 'package:siangmalam/widgets/custom_input.dart';

/* Created By Dwi Sutrisno */

class DeviceInfoForm extends GetView<DeviceInfoController> {
  DeviceInfoForm({Key? key}) : super(key: key);

  bool genderValue = true;
  var genders = {"Pria": true, "Wanita": false};

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);

    const deviceNameTxt = 'DeviceName';
    const deviceVersionTxt = 'Device Version';
    const deviceIdTxt = 'Device ID';

    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            CustomInputFieldWithController(
              controller: controller.deviceNameController,
              hint: deviceNameTxt,
              label: deviceNameTxt,
              enable: true,
              icon: Icons.info,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {},
              validationBuilder: ValidationBuilder(requiredMessage: firstNameInputMessage).minLength(3, firstNameValidationMessage).build(),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            CustomInputFieldWithController(
              controller: controller.deviceVersionController,
              hint: deviceVersionTxt,
              label: deviceVersionTxt,
              enable: true,
              icon: Icons.info,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {},
              validationBuilder: null,
            ),
            SizedBox(
              height: 1.5.h,
            ),
            CustomInputFieldWithController(
              controller: controller.deviceIdController,
              hint: deviceIdTxt,
              label: deviceIdTxt,
              enable: true,
              icon: Icons.info,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {},
              validationBuilder: ValidationBuilder(requiredMessage: address1InputMessage).minLength(5, addres1ValidationMessage).build(),
            ),
            SizedBox(height: 3.h),
            CustomButton(
              text: "Tutup",
              icon: Icons.close,
              press: () {
                // controller.submitProfile();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
