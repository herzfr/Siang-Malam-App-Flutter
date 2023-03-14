import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siangmalam/commons/controllers/saving/saving_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:sizer/sizer.dart';

class SavingScreen extends GetView<SavingController> {
  static String routeName = " /saving";
  const SavingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context),
        body: body(context));
  }

  Container body(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(5.sp),
          child: Column(
            children: [
              SizedBox(height: 0.5.h),
              DropdownButtonFormField<int>(
                // key: controller.dropStatus,
                items: controller.dDBranch,
                value: controller.subBranchId,
                isExpanded: true,
                style: TextStyle(fontSize: 12.sp, color: mtGrey800),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.0.h),
                  label: Text("Cabang",
                      style: TextStyle(fontSize: 12.sp, color: mtGrey800)),
                  helperStyle: TextStyle(fontSize: 8.sp, color: mtGrey800),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: primaryGrey),
                    borderRadius: BorderRadius.circular(1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: primaryGrey),
                    borderRadius: BorderRadius.circular(1),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: primaryGrey),
                    borderRadius: BorderRadius.circular(1),
                  ),
                ),
                onChanged: (value) {
                  controller.subBranchId = value;
                  controller.onBranch();
                },
              ),
              SizedBox(height: 1.h),
              Obx(
                () => SizedBox(
                  // height: 3.h,
                  child: Card(
                      child: ListTile(
                    leading: Icon(
                      Icons.wallet_travel,
                      size: 14.sp,
                      color: primaryGoldText,
                    ),
                    trailing: Obx(
                      () => Text(
                        controller.convertPrice(
                            controller.savingMoney.value.savingAmount),
                        style: GoogleFonts.raleway(
                            fontSize: 12.sp,
                            color: primaryGoldText,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      controller.savingMoney.value.name ?? "-",
                      style: GoogleFonts.raleway(
                          fontSize: 12.sp,
                          color: primaryDarkGreen,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      controller.converDateMillisToString(
                          controller.savingMoney.value.updatedAt ?? 0),
                      style: GoogleFonts.raleway(
                          fontSize: 8.sp,
                          color: primaryDarkGreen,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
                ),
              ),
              SizedBox(height: 1.h),
              Obx(
                () => Padding(
                    padding: EdgeInsets.all(1.sp),
                    child: Form(
                      key: controller.formKeyAmount,
                      child: TextFormField(
                        enabled: true,
                        style: TextStyle(fontSize: 12.sp, color: mtGrey800),
                        controller: controller.textAmountController.value,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          CurrencyTextInputFormatter(
                            locale: 'id',
                            decimalDigits: 0,
                            symbol: 'Rp ',
                          ),
                        ],
                        onSaved: (String? val) {},
                        validator: ValidationBuilder(
                                requiredMessage: "Mohon diisi terlebih dahulu")
                            .minLength(4, "Minimal 4 karakter!")
                            .build(),
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          isDense: true,
                          label: Text(
                            "Ubah Jumlah Celengan",
                            style: TextStyle(fontSize: 12.sp),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: primaryLightGrey),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: primaryLightGrey),
                            borderRadius: BorderRadius.circular(40),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 2, color: primaryDarkGreen),
                            borderRadius: BorderRadius.circular(40),
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          controller.textAmountController.value.text = value;
                        },
                        onChanged: (value) =>
                            {controller.onChangeValueAmount(value)},
                      ),
                    )),
              ),
              SizedBox(height: 1.h),
              const Spacer(),
              ElevatedButton.icon(
                label: Text('Ubah', style: TextStyle(fontSize: 12.sp)),
                icon: Icon(
                  Icons.arrow_right,
                  size: 12.sp,
                ),
                onPressed: () {
                  controller.setSavingMoney();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(8.h),
                  primary: primaryDarkGreen,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: primaryDarkGreen,
      leading: IconButton(
        padding: EdgeInsets.only(left: 0.w),
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Text(
        "Uang Celengan",
        style: TextStyle(color: Colors.white, fontSize: 9.sp),
      ),
    );
  }
}
