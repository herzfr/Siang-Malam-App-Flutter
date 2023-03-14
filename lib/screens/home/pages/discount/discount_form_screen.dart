import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siangmalam/commons/controllers/discount/discount_form_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';

class DiscountFormScreen extends GetView<DiscountFormController> {
  static String routeName = "/discount/form";
  const DiscountFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundimage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 237, 248, 243),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0), // here the desired height
          child: buildAppBar(context),
        ),
        bottomNavigationBar: Material(
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
                height: kToolbarHeight,
                width: double.infinity,
                child: getSearchControll()),
          ),
        ),
        body: const DiscountForm(),
      ),
    );
  }

  getSearchControll() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: OutlinedButton(
          style: ElevatedButton.styleFrom(
            primary: primaryGoldText,
            side: const BorderSide(width: 0.0, color: Colors.transparent),
          ),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 16.sp,
                  )),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Submit',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.raleway(
                      fontSize: 12.sp,
                      color: Colors.white,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          onPressed: () {
            if (controller.isNewDiscount.isTrue) {
              controller.submitCreate();
            } else {
              controller.submitUpdate();
            }
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      backgroundColor: primaryDarkGreen,
      elevation: 2,
      leading: IconButton(
        padding: EdgeInsets.only(left: 5.w),
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Text(
        "Info Diskon",
        style: TextStyle(fontSize: 18.0.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class DiscountForm extends GetView<DiscountFormController> {
  const DiscountForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var node = FocusScope.of(context);

    return Form(
      key: controller.formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 1.5.h,
              ),
              CustomInputFieldWithController(
                controller: controller.nameController.value,
                hint: 'Masukan nama diskon',
                label: "Nama",
                enable: true,
                icon: Icons.edit,
                node: node,
                inputType: TextInputType.text,
                dataInstance: (String? val) {},
                validationBuilder:
                    ValidationBuilder(requiredMessage: 'Nama tidak terisi')
                        .minLength(5, "minimal 5 karakter")
                        .build(),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              CustomInputFieldWithController(
                controller: controller.descriptionController.value,
                hint: 'Masukan deskripsi diskon',
                label: "Deskripsi",
                enable: true,
                icon: Icons.note,
                node: node,
                inputType: TextInputType.text,
                dataInstance: (String? val) {},
                validationBuilder:
                    ValidationBuilder(requiredMessage: 'Deskripsi tidak terisi')
                        .minLength(5, "minimal 5 karakter")
                        .build(),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Obx(() {
                return DropdownButtonFormField<String>(
                  // key: controller.dropStatus,
                  items: controller.typeDrop,
                  value: controller.typeController.value.text,
                  decoration:
                      CustomFormWidget.customInputDecoration('', 'Tipe'),
                  onChanged: (value) {
                    controller.typeController.value.text = value!;
                    // controller.searchDataGeneral();
                  },
                );
              }),
              SizedBox(
                height: 1.5.h,
              ),
              CustomInputFieldWithController(
                controller: controller.valueController.value,
                hint: 'Masukan Nilai/Jumlah',
                label: "Nilai/Jumlah",
                enable: true,
                icon: controller.typeController.value.text == 'PERCENT'
                    ? Icons.percent
                    : Icons.monetization_on,
                node: node,
                inputType: TextInputType.number,
                dataInstance: (String? val) {},
                validationBuilder:
                    ValidationBuilder(requiredMessage: 'Nilai wajib terisi')
                        .build(),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Obx(() {
                return DropdownButtonFormField<int>(
                  key: controller.dropBranch,
                  items: controller.branchDropDown,
                  value:
                      int.tryParse(controller.branchIdController.value.text) ??
                          0,
                  decoration:
                      CustomFormWidget.customInputDecoration('', 'Cabang'),
                  onChanged: (value) {
                    print(value);
                    controller.branchIdController.value.text = value.toString();
                    controller.getDataSubBranch(value!);
                  },
                );
              }),
              SizedBox(
                height: 1.5.h,
              ),
              Obx(() {
                return DropdownButtonFormField<int>(
                  // key: controller.dropStatus,
                  items: controller.subbranchDropDown,
                  value: controller.discSelected.value.subBranchId,
                  // value: int.parse(controller.subBranchIdController.value.text),
                  decoration:
                      CustomFormWidget.customInputDecoration('', 'Anak Cabang'),
                  onChanged: (value) {
                    controller.discSelected.value.subBranchId = value;
                    controller.discSelected.refresh();
                  },
                );
                // if (controller.discSelected.value.branchId != 0) {
                //   return DropdownButtonFormField<int>(
                //     // key: controller.dropStatus,
                //     items: controller.subbranchDropDown,
                //     value:
                //         int.parse(controller.subBranchIdController.value.text),
                //     decoration: CustomFormWidget.customInputDecoration(
                //         '', 'Anak Cabang'),
                //     onChanged: (value) {
                //       controller.subBranchIdController.value.text =
                //           value.toString();
                //     },
                //   );
                // } else {
                //   return DropdownButtonFormField<int>(
                //     // key: controller.dropStatus,
                //     items: controller.subbranchDropDown,
                //     value:
                //         int.parse(controller.subBranchIdController.value.text),
                //     decoration: CustomFormWidget.customInputDecoration(
                //         '', 'Anak Cabang'),
                //     onChanged: (value) {
                //       controller.subBranchIdController.value.text =
                //           value.toString();
                //     },
                //   );
                // }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
