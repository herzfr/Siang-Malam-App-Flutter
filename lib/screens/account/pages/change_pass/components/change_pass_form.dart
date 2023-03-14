import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:form_validator/form_validator.dart';
import 'package:siangmalam/commons/custom_style.dart';
import 'package:siangmalam/constans/form_values.dart';
import 'package:siangmalam/widgets/custom_button.dart';
import 'package:siangmalam/commons/controllers/profile/change_pass_controller.dart';

/* Created By Dwi Sutrisno */

class ChangePassForm extends GetView<ChangePassController> {
  const ChangePassForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Obx(
        () => Form(
          key: controller.formKey,
          child: Column(
            children: [
              TextFormField(
                textInputAction: TextInputAction.go,
                controller: controller.passwordInputController,
                validator: ValidationBuilder(requiredMessage: 'Mohon inputkan sandi').minLength(5, passwordInputVldMsg).build(),
                obscureText: controller.obscureText.value,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    border: outlineInputBorder,
                    hintText: "Input Sandi",
                    labelText: "Sandi",
                    labelStyle: const TextStyle(color: primaryGrey),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 2.h,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.togglePass();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: Icon(
                          controller.getPassIcon(),
                          color: primaryGrey,
                          size: 6.5.w,
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 3.h,
              ),
              TextFormField(
                textInputAction: TextInputAction.go,
                controller: controller.passwordVerifInputController,
                validator: ValidationBuilder(requiredMessage: 'Mohon inputkan verifikasi sandi').minLength(5, passwordInputVldMsg).build(),
                obscureText: controller.obscureVerifText.value,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    border: outlineInputBorder,
                    hintText: "Verifikasi Sandi",
                    labelText: "Verifikasi Sandi",
                    labelStyle: const TextStyle(color: primaryGrey),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 2.h,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.toggleVerifPass();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: Icon(
                          controller.getPassVerifIcon(),
                          color: primaryGrey,
                          size: 6.5.w,
                        ),
                      ),
                    )),
              ),
              SizedBox(
                height: 3.h,
              ),
              CustomButton(
                  text: btnSaveTxt,
                  icon: Icons.save,
                  press: () {
                    controller.submitPassword();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
