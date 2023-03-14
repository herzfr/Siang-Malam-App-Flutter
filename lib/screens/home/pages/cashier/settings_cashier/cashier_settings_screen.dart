import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/cashier/cashier_settings_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';

class CashierSettingScreen extends GetView<CashierSettingsController> {
  static String routeName = " /cashier_settings";
  const CashierSettingScreen({Key? key}) : super(key: key);

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
          padding: EdgeInsets.all(1.sp),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(1.sp),
                      child: Column(
                        children: [
                          Obx(
                            () {
                              return DropdownButtonFormField<BluetoothDevice>(
                                key: controller.dropdownState,
                                items: controller.menuItems,
                                value: controller.deviceChoose.value,
                                isExpanded: true,
                                style:
                                    TextStyle(fontSize: 8.sp, color: mtGrey800),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 1.5.h),
                                  label: Text("Pilih Device",
                                      style: TextStyle(
                                          fontSize: 8.sp, color: mtGrey800)),
                                  helperStyle: TextStyle(
                                      fontSize: 8.sp, color: mtGrey800),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: primaryGrey),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: primaryGrey),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        width: 2, color: primaryGrey),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                ),
                                onChanged: controller.isConnected.isFalse
                                    ? (value) {
                                        controller.deviceChoose.value = value!;
                                        controller.checkConnection();
                                        // controller.logger();
                                      }
                                    : null,
                              );
                            },
                          ),
                          Expanded(
                            flex: 1,
                            child: SizedBox(
                                // height: 0.5.h,
                                child: Center(
                                    child: Obx(
                              () => controller.isProgress.isTrue
                                  ? const LinearProgressIndicator(
                                      backgroundColor: Colors.grey,
                                    )
                                  : Text(
                                      controller.messages.value,
                                      style: TextStyle(
                                          fontSize: 9.sp, color: Colors.black),
                                      textAlign: TextAlign.center,
                                    ),
                            ))),
                          ),
                          Expanded(
                              flex: 1,
                              child: Obx(
                                () => ElevatedButton(
                                  child: Text('Koneksikan',
                                      style: TextStyle(fontSize: 6.sp)),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(100),
                                    primary: primaryBlue,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  onPressed: controller.isConnected.isFalse
                                      ? () {
                                          controller.connectedDevice();
                                        }
                                      : null,
                                ),
                              )),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              child: Text('Check Koneksi',
                                  style: TextStyle(fontSize: 6.sp)),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(100),
                                primary: primaryBlue,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              onPressed: () {
                                controller.checkConnection();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Expanded(
                            flex: 1,
                            child: ElevatedButton(
                              child: Text('Putus Koneksi',
                                  style: TextStyle(fontSize: 6.sp)),
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(100),
                                primary: primaryBlue,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              onPressed: () {
                                controller.cutConnection();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Expanded(
                              flex: 1,
                              child: Obx(
                                () => ElevatedButton(
                                  child: Text('Test Print',
                                      style: TextStyle(fontSize: 6.sp)),
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size.fromHeight(100),
                                    primary: primaryBlue,
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                  ),
                                  onPressed: controller.isConnected.isTrue
                                      ? () {
                                          controller.testPrint();
                                        }
                                      : null,
                                ),
                              )),
                        ],
                      ),
                    ),
                  )),
              Expanded(
                flex: 1,
                child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(1.sp),
                      child: Column(children: [
                        SizedBox(
                          child: Text(
                            "Atur Print",
                            style: TextStyle(
                                fontSize: 9.sp, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            style: TextStyle(
                                fontSize: 8.sp, fontWeight: FontWeight.normal),
                            enabled: true,
                            maxLines: 3,
                            controller: controller.tfBranch.value,
                            keyboardType: TextInputType.text,
                            onSaved: (String? val) {},
                            decoration: InputDecoration(
                              fillColor: primaryLightGrey,
                              filled: true,
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              focusedBorder: InputBorder.none,
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 5.w),
                              suffixIconConstraints:
                                  BoxConstraints(minWidth: 5.w),
                              // border: outlineInputBorder,
                              hintText: "Cabang",
                              label: Text(
                                "Cabang",
                                style: TextStyle(
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              errorText: null,
                              labelStyle: const TextStyle(color: primaryGrey),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.h),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 1.w),
                                child: Icon(
                                  Icons.home_filled,
                                  color: primaryGoldText,
                                  size: 9.sp,
                                ),
                              ),
                            ),
                            onChanged: (value) {},
                            // onEditingComplete: () => node.nextFocus(),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            style: TextStyle(
                                fontSize: 8.sp, fontWeight: FontWeight.normal),
                            enabled: true,
                            maxLines: 5,
                            controller: controller.tfAddress.value,
                            keyboardType: TextInputType.text,
                            onSaved: (String? val) {},
                            decoration: InputDecoration(
                              fillColor: primaryLightGrey,
                              filled: true,
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              focusedBorder: InputBorder.none,
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 5.w),
                              suffixIconConstraints:
                                  BoxConstraints(minWidth: 5.w),
                              // border: outlineInputBorder,
                              hintText: "Alamat",
                              label: Text(
                                "Alamat",
                                style: TextStyle(
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              errorText: null,
                              labelStyle: const TextStyle(color: primaryGrey),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.h),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 1.w),
                                child: Icon(
                                  Icons.roundabout_left,
                                  color: primaryGoldText,
                                  size: 9.sp,
                                ),
                              ),
                            ),
                            onChanged: (value) {},
                            // onEditingComplete: () => node.nextFocus(),
                          ),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            style: TextStyle(
                                fontSize: 8.sp, fontWeight: FontWeight.normal),
                            enabled: true,
                            maxLines: 5,
                            controller: controller.tfInfo.value,
                            keyboardType: TextInputType.text,
                            onSaved: (String? val) {},
                            decoration: InputDecoration(
                              fillColor: primaryLightGrey,
                              filled: true,
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1),
                              ),
                              focusedBorder: InputBorder.none,
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 5.w),
                              suffixIconConstraints:
                                  BoxConstraints(minWidth: 5.w),
                              // border: outlineInputBorder,
                              hintText: "Info",
                              label: Text(
                                "Info",
                                style: TextStyle(
                                    fontSize: 9.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              errorText: null,
                              labelStyle: const TextStyle(color: primaryGrey),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 1.h),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 1.w),
                                child: Icon(
                                  Icons.info,
                                  color: primaryGoldText,
                                  size: 9.sp,
                                ),
                              ),
                            ),
                            onChanged: (value) {},
                            // onEditingComplete: () => node.nextFocus(),
                          ),
                        ),
                        // Expanded(flex: 6, child: Container()),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                            child: Text('Simpan',
                                style: TextStyle(fontSize: 6.sp)),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(100),
                              primary: primaryBlue,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onPressed: () => {controller.saveSettingPrint()},
                          ),
                        ),
                      ]),
                    )),
              ),
              // Expanded(
              //     flex: 1,
              //     child: Container(
              //       color: Colors.transparent,
              //       child: const Center(child: Text("Cooming Soon")),
              //     )),
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     color: Colors.transparent,
              //     child: const Center(child: Text("Cooming Soon")),
              //   ),
              // ),
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
      title: Column(
        children: const [
          Text(
            "Pengaturan",
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
