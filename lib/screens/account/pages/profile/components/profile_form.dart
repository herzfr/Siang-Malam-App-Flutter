// class ProfileForm extends StatelessWidget {
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/widgets/custom_button.dart';
import 'package:sizer/sizer.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/profile/profile_form_controller.dart';
import 'package:siangmalam/constans/form_values.dart';
import 'package:siangmalam/widgets/custom_input.dart';

/* Created By Dwi Sutrisno */

class ProfileForm extends GetView<ProfileFormController> {
  ProfileForm({Key? key}) : super(key: key);

  bool genderValue = true;
  var genders = {"Pria": true, "Wanita": false};

  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);

    return Form(
      key: controller.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          children: [
            CustomInputFieldWithController(
              controller: controller.firstNameController,
              hint: firstNameInput,
              label: firstNameInput,
              enable: true,
              icon: Icons.person,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {},
              validationBuilder:
                  ValidationBuilder(requiredMessage: firstNameInputMessage)
                      .minLength(3, firstNameValidationMessage)
                      .build(),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            CustomInputFieldWithController(
              controller: controller.lastNameController,
              hint: lastNameInput,
              label: lastNameInput,
              enable: true,
              icon: Icons.person,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {},
              validationBuilder: null,
            ),
            SizedBox(
              height: 1.5.h,
            ),
            CustomInputFieldWithController(
              controller: controller.address1Controller,
              hint: address1Input,
              label: address1Input,
              enable: true,
              icon: Icons.location_on,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {},
              validationBuilder:
                  ValidationBuilder(requiredMessage: address1InputMessage)
                      .minLength(5, addres1ValidationMessage)
                      .build(),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            CustomInputFieldWithController(
              controller: controller.address2Controller,
              hint: address2Input,
              label: address2Input,
              enable: true,
              icon: Icons.location_on,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {},
              validationBuilder: null,
            ),
            SizedBox(
              height: 2.h,
            ),
            CustomInputFieldWithController(
              controller: controller.address3Controller,
              hint: address3Input,
              label: address3Input,
              enable: true,
              icon: Icons.location_on,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {},
              validationBuilder: null,
            ),
            SizedBox(
              height: 2.h,
            ),
            DropdownButtonFormField(
              decoration: CustomFormWidget.customInputDecoration(
                  genderChooseInput, genderInput),
              value: controller.genderValue.value,
              onChanged: (bool? value) {
                controller.setGender(value);
              },
              icon: const Icon(Icons.male),
              focusNode: FocusNode(),
              items: genders
                  .map((description, value) {
                    return MapEntry(
                      description,
                      DropdownMenuItem(
                        value: value,
                        child: Text(description),
                      ),
                    );
                  })
                  .values
                  .toList(),
            ),
            SizedBox(height: 1.5.h),
            CustomInputFieldWithController(
              controller: controller.phoneController,
              hint: phoneInput,
              label: phoneInput,
              enable: true,
              icon: Icons.call,
              node: node,
              inputType: TextInputType.phone,
              dataInstance: (String? val) {},
              validationBuilder:
                  ValidationBuilder().phone(userNameInputVldMsg).build(),
            ),
            SizedBox(height: 1.5.h),
            CustomInputFieldWithController(
              controller: controller.emailController,
              hint: emailInput,
              label: emailInput,
              enable: true,
              icon: Icons.email,
              node: node,
              inputType: TextInputType.emailAddress,
              dataInstance: (String? val) {},
              validationBuilder:
                  ValidationBuilder().email(userNameInputVldMsg).build(),
            ),
            SizedBox(height: 3.h),
            CustomButton(
              text: btnSaveTxt,
              icon: Icons.save,
              press: () {
                controller.submitProfile();
              },
            ),
          ],
        ),
      ),
    );
  }
}
