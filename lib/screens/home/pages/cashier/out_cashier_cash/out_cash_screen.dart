import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siangmalam/commons/controllers/cashier/out_cash_controller.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:sizer/sizer.dart';

class OutCashScreen extends GetView<OutCashController> {
  static String routeName = "/out-cash";
  const OutCashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context),
        body: body(context),
      ),
    );
  }

  Container body(BuildContext context) {
    return Container(
      child: Padding(
          padding: EdgeInsets.all(1.sp),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(backgroundimagerm),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(3.sp),
                      child: Column(children: [
                        Obx(
                          () => SizedBox(
                            // height: 3.h,
                            child: Card(
                                child: ListTile(
                              leading: Icon(
                                Icons.monetization_on,
                                size: 14.sp,
                                color: primaryGoldText,
                              ),
                              trailing: Obx(
                                () => Text(
                                  controller.convertPrice(
                                      controller.shiftData.value.endCash),
                                  style: GoogleFonts.raleway(
                                      fontSize: 9.sp,
                                      color: primaryGoldText,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              title: Text(
                                controller.shiftData.value.name ?? "-",
                                style: GoogleFonts.raleway(
                                    fontSize: 7.sp,
                                    color: primaryDarkGreen,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                controller.shiftData.value.startTime ?? "-",
                                style: GoogleFonts.raleway(
                                    fontSize: 6.sp,
                                    color: primaryDarkGreen,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Obx(
                          () => ElevatedButton.icon(
                            label: Text('Kasbon Karyawan',
                                style: TextStyle(fontSize: 6.sp)),
                            icon: Icon(
                              Icons.arrow_right,
                              size: 12.sp,
                            ),
                            onPressed: () {
                              controller.changeForm(0);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(100),
                              primary: controller.indexForm.value == 0
                                  ? primaryDarkGreen
                                  : primaryGrey,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Obx(
                          () => ElevatedButton.icon(
                            label: Text('Pengeluaran Belanja',
                                style: TextStyle(fontSize: 6.sp)),
                            icon: Icon(
                              Icons.arrow_right,
                              size: 12.sp,
                            ),
                            onPressed: () {
                              controller.changeForm(1);
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(100),
                              primary: controller.indexForm.value == 1
                                  ? primaryDarkGreen
                                  : primaryGrey,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ),
                  )),
              Expanded(
                  flex: 6,
                  child: Container(
                      color: Colors.transparent,
                      child: Obx(
                        () => getView(context),
                      ))),
            ],
          )),
    );
  }

  Padding getView(BuildContext context) {
    switch (controller.indexForm.value) {
      case 0:
        return Padding(
            padding: EdgeInsets.all(3.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    "Kasbon Karyawan",
                    style: GoogleFonts.raleway(
                        fontSize: 9.sp,
                        color: primaryGoldText,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.all(3.sp),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Padding(
                              padding: EdgeInsets.all(1.sp),
                              child: searchFieldIdKaryawan(context)),
                        ),
                        SizedBox(
                          width: 1.w,
                        ),
                        Expanded(
                          flex: 4,
                          child: ElevatedButton.icon(
                            label: Text('Scan Qr Karyawan',
                                style: TextStyle(fontSize: 5.sp)),
                            icon: Icon(Icons.qr_code_2, size: 12.sp),
                            onPressed: () async {
                              Get.toNamed(RouteName.cashierQrCodeScreen)!
                                  .then((value) async => {
                                        if (value != null)
                                          {
                                            controller.userIdController.value
                                                .text = value,
                                            await controller.fetchUserById(
                                                controller.userIdController
                                                    .value.text)
                                          }
                                      });
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(100),
                              primary: primaryDarkGreen,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  child: Text(
                    "Data Karyawan",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.raleway(
                        fontSize: 9.sp,
                        color: primaryGoldText,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                      padding: EdgeInsets.all(3.sp),
                      child: ListTile(
                        leading: Icon(
                          Icons.person,
                          size: 14.sp,
                          color: primaryGoldText,
                        ),
                        trailing: Text(
                          controller.userDto.value.id ?? "-",
                          style: GoogleFonts.raleway(
                              fontSize: 9.sp,
                              color: primaryGrey,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                        title: Text(
                          controller.userDto.value.firstName ?? "-",
                          style: GoogleFonts.raleway(
                              fontSize: 12.sp,
                              color: primaryDarkGreen,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          controller.userDto.value.username ?? "-",
                          style: GoogleFonts.raleway(
                              fontSize: 9.sp,
                              color: primaryDarkGreen,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                SizedBox(
                  child: Text(
                    "Jumlah kas yang dikeluarkan",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.raleway(
                        fontSize: 9.sp,
                        color: primaryGoldText,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 0.5.h,
                ),
                Expanded(
                  flex: 2,
                  child: Obx(
                    () => Padding(
                        padding: EdgeInsets.all(1.sp),
                        child: Form(
                          key: controller.formKeyAmount,
                          child: TextFormField(
                            enabled: true,
                            style: TextStyle(fontSize: 8.sp, color: mtGrey800),
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
                                    requiredMessage:
                                        "Mohon diisi terlebih dahulu")
                                .minLength(4, "Minimal 4 karakter!")
                                .build(),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              isDense: true,
                              label: Text(
                                "Jumlah Kas",
                                style: TextStyle(fontSize: 8.sp),
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
                              controller.textAmountController.value.text =
                                  value;
                            },
                            onChanged: (value) =>
                                {controller.onChangeValueAmount(value)},
                          ),
                        )),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: Container(),
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Obx(
                            () => ElevatedButton.icon(
                              label: Text('Setujui',
                                  style: TextStyle(fontSize: 6.sp)),
                              icon: Icon(
                                Icons.arrow_right,
                                size: 12.sp,
                              ),
                              onPressed: controller.userDto.value.id != null
                                  ? () {
                                      Get.defaultDialog(
                                          title: "Buat?",
                                          middleText:
                                              "Anda akan ingin kasbon karyawa ${controller.userDto.value.firstName}, lanjutkan?",
                                          backgroundColor: whiteBg,
                                          titleStyle:
                                              const TextStyle(color: mtGrey700),
                                          middleTextStyle:
                                              const TextStyle(color: mtGrey700),
                                          textConfirm: confirmYes,
                                          textCancel: confirmNo,
                                          cancelTextColor: mtGrey700,
                                          confirmTextColor: mtGrey700,
                                          buttonColor: primaryYellow,
                                          onConfirm: () {
                                            Get.back();
                                            controller.updateEmplCashout();
                                          });
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(100),
                                primary: controller.indexForm.value == 0
                                    ? primaryDarkGreen
                                    : primaryGrey,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 0.5.w,
                        ),
                        Expanded(
                          flex: 3,
                          child: ElevatedButton.icon(
                            label:
                                Text('Clear', style: TextStyle(fontSize: 6.sp)),
                            icon: Icon(
                              Icons.refresh,
                              size: 12.sp,
                            ),
                            onPressed: () {
                              controller.clearDataEmpl();
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(100),
                              primary: primaryGoldText,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ));
      default:
        return Padding(
          padding: EdgeInsets.all(3.sp),
          child: Container(),
        );
    }
  }

  Center searchFieldIdKaryawan(BuildContext context) {
    return Center(
      child: Container(
          // width: 100.w,
          // height: 40.h,
          padding: EdgeInsets.all(1.sp),
          color: primaryDarkGreen,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                  child: Obx(
                () => TextField(
                  controller: controller.userIdController.value,
                  style: TextStyle(fontSize: 7.sp, color: Colors.white),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            width: 1, color: primaryDarkGreen)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(
                            width: 1, color: primaryDarkGreen)),
                    hintText: "ID...",
                    filled: true,
                    fillColor: primaryLightGrey.withOpacity(.5),
                  ),
                ),
              )),
              FittedBox(
                // fit: BoxFit.fill,
                child: InkWell(
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    await controller
                        .fetchUserById(controller.userIdController.value.text);
                  },
                  child: Icon(Icons.search_outlined,
                      size: 9.sp, color: Colors.white),
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
          Get.back(result: true);
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Column(
        children: const [
          Text(
            "Kas keluar",
            style: TextStyle(color: Colors.white),
          ),
          Text(
            "Kasir",
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
