// import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:barcode/barcode.dart';
// import 'package:qr_flutter/qr_flutter.dart';
import 'package:siangmalam/commons/controllers/home/home_controller.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/colors.dart';

/* Created By Dwi Sutrisno */

class DiscountBanner extends GetView<HomeController> {
  const DiscountBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
        width: double.infinity,
        // height: 8.5.h,
        decoration: BoxDecoration(
            color: primaryDarkGreen,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ]),
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Obx(() => Text.rich(
                    TextSpan(
                        text: "Hi, ${AppStatic.userData.firstName}\n",
                        style: TextStyle(
                          color: textColor,
                          fontSize: 9.sp,
                        ),
                        children: [
                          TextSpan(
                            text: controller.greeting.value,
                            style: TextStyle(
                              fontSize: 9.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                  )),
            ),
            Expanded(
              flex: 3,
              child: ElevatedButton.icon(
                label: Text('SHOW QR', style: TextStyle(fontSize: 6.sp)),
                icon: Icon(Icons.qr_code, size: 12.sp),
                onPressed: () {
                  showQrDialog(context);
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
            )
          ],
        ));
  }

  Future<void> showQrDialog(BuildContext context) async {
    var isQrCode = true;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: false,
          title: Text(
              "${AppStatic.userData.firstName} ${AppStatic.userData.lastName} ID : ${AppStatic.userData.id}",
              style: TextStyle(fontSize: 8.sp)),
          content: Container(
            child: Center(
              child: Obx(() => controller.isShow.isTrue
                  ? SvgPicture.string(
                      controller.buildBarcode(
                        Barcode.code39(),
                        AppStatic.userData.id.toString(),
                      ),
                      allowDrawingOutsideViewBox: true,
                    )
                  : SvgPicture.string(
                      controller.buildBarcode(
                          Barcode.qrCode(), AppStatic.userData.id.toString(),
                          height: 40.h, width: 40.w),
                      allowDrawingOutsideViewBox: true,
                    )),
            ),
            height: 30.h,
            width: 60.w,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Ganti', style: TextStyle(fontSize: 6.sp)),
              onPressed: () {
                if (controller.isShow.isTrue) {
                  controller.isShow.value = false;
                } else {
                  controller.isShow.value = true;
                }
              },
            ),
            TextButton(
              child: Text('Tutup', style: TextStyle(fontSize: 6.sp)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // buildBarcode(
  //   Barcode bc,
  //   String data, {
  //   String? filename,
  //   double? width,
  //   double? height,
  //   double? fontHeight,
  // }) {
  //   /// Create the Barcode
  //   var svg = bc.toSvg(
  //     data,
  //     width: width ?? 200,
  //     height: height ?? 80,
  //     fontHeight: fontHeight,
  //   );
  //   return svg;
  // }
}
