import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/customer/customer_form_controller.dart';
import 'package:siangmalam/constans/form_values.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/widgets/custom_back_app_bar.dart';
import 'package:siangmalam/widgets/custom_button.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';

class CustomerFormScreen extends StatelessWidget {
  static String routeName = "/customer/form";
  const CustomerFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: 100.h),
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage(backgroundimage),
            fit: BoxFit.cover,
          )),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CustomBackAppBar(),
              SizedBox(
                height: 2.5.h,
              ),
              Text(
                "Info Pelanggan",
                style:
                    TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3.h,
              ),
              const CustomerForm()
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerForm extends GetView<CustomerFormController> {
  const CustomerForm({Key? key}) : super(key: key);
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
              controller: controller.nameController,
              hint: 'Masukan nama',
              label: nameInput,
              enable: true,
              icon: Icons.person,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {},
              validationBuilder:
                  ValidationBuilder(requiredMessage: nameInputMessage)
                      .minLength(3, nameValidationMessage)
                      .build(),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            CustomInputFieldWithController(
              controller: controller.address1Controller,
              hint: 'Masukan alamat 1',
              label: address1Input,
              enable: true,
              icon: Icons.location_on,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {},
              validationBuilder:
                  ValidationBuilder(requiredMessage: address1InputMessage)
                      .minLength(5, addres1ValidationMessages)
                      .build(),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            CustomInputFieldWithController(
              controller: controller.address2Controller,
              hint: 'Masukan alamat 2',
              label: address2Input,
              enable: true,
              icon: Icons.location_on,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {},
              validationBuilder: ValidationBuilder().build(),
            ),
            SizedBox(
              height: 1.5.h,
            ),
            CustomInputFieldWithController(
              controller: controller.address3Controller,
              hint: 'Masukan alamat 3',
              label: address3Input,
              enable: true,
              icon: Icons.location_on,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {},
              validationBuilder: ValidationBuilder().build(),
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
                  ValidationBuilder().phone(min3inputVldMsg).build(),
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
