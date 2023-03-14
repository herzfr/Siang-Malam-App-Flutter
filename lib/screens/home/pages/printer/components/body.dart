import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/printer/printer_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/form_values.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/widgets/custom_button.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';

class Body extends GetView<PrinterController> {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
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
                  style: TextStyle(fontSize: 8.sp, color: mtGrey800),
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
                    label: Text("Pilih Device",
                        style: TextStyle(fontSize: 8.sp, color: mtGrey800)),
                    helperStyle: TextStyle(fontSize: 8.sp, color: mtGrey800),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: primaryGrey),
                      borderRadius: BorderRadius.circular(1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: primaryGrey),
                      borderRadius: BorderRadius.circular(1),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: primaryGrey),
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
                        style: TextStyle(fontSize: 9.sp, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
              ))),
            ),
            Expanded(
                flex: 1,
                child: Obx(
                  () => ElevatedButton(
                    child:
                        Text('Koneksikan', style: TextStyle(fontSize: 10.sp)),
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
                child: Text('Check Koneksi', style: TextStyle(fontSize: 10.sp)),
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
                child: Text('Putus Koneksi', style: TextStyle(fontSize: 10.sp)),
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
                    child:
                        Text('Test Print', style: TextStyle(fontSize: 10.sp)),
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
    );
  }

  // getButtonView() {
  //   if (controller.connected == true) {
  //     return TextButton(
  //         style: TextButton.styleFrom(
  //           elevation: 5,
  //           primary: mtGrey700,
  //           padding: EdgeInsets.all(3.4.w),
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //           backgroundColor: primaryGreen,
  //         ),
  //         child: Row(
  //           children: [
  //             SizedBox(width: 5.w),
  //             Expanded(
  //                 child: Text(
  //               'Matikan',
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                   fontSize: 13.sp,
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold),
  //             )),
  //             controller.isLoading.isFalse
  //                 ? Icon(
  //                     Icons.cast_connected,
  //                     color: Colors.white,
  //                     size: 3.5.h,
  //                   )
  //                 : const SizedBox(
  //                     height: 30,
  //                     width: 30,
  //                     child: CircularProgressIndicator(
  //                       valueColor: AlwaysStoppedAnimation(Colors.white),
  //                       backgroundColor: Colors.blue,
  //                       strokeWidth: 3,
  //                     ),
  //                   ),
  //           ],
  //         ),
  //         onPressed: () => controller.disconnectDevice());
  //   } else {
  //     return TextButton(
  //         style: TextButton.styleFrom(
  //           elevation: 5,
  //           primary: mtGrey700,
  //           padding: EdgeInsets.all(3.4.w),
  //           shape:
  //               RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
  //           backgroundColor: primaryGreen,
  //         ),
  //         child: Row(
  //           children: [
  //             SizedBox(width: 5.w),
  //             Expanded(
  //                 child: Text(
  //               'Matikan',
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                   fontSize: 13.sp,
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold),
  //             )),
  //             controller.isLoading.isFalse
  //                 ? Icon(
  //                     Icons.cast_connected,
  //                     color: Colors.white,
  //                     size: 3.5.h,
  //                   )
  //                 : const SizedBox(
  //                     height: 30,
  //                     width: 30,
  //                     child: CircularProgressIndicator(
  //                       valueColor: AlwaysStoppedAnimation(Colors.white),
  //                       backgroundColor: Colors.blue,
  //                       strokeWidth: 3,
  //                     ),
  //                   ),
  //           ],
  //         ),
  //         onPressed: () => controller.disconnectDevice());
  //   }
  // }
}
