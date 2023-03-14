// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/cashier/qrcode_controller.dart';
// import 'package:siangmalam/constans/colors.dart';
// import 'package:sizer/sizer.dart';

class CashierQrCodeScreen extends GetView<QrCodeController> {
  const CashierQrCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container();
  }

  // @override
  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return Scaffold(
  //     body: Column(
  //       children: <Widget>[
  //         Expanded(flex: 8, child: _buildQrView(context)),
  //         Expanded(
  //           flex: 2,
  //           child: Container(
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 Expanded(
  //                   flex: 2,
  //                   child: Container(
  //                     color: Colors.transparent,
  //                     margin: const EdgeInsets.all(8),
  //                     child: ElevatedButton(
  //                         style: ElevatedButton.styleFrom(
  //                           minimumSize: Size.fromHeight(5.h),
  //                           primary: primaryGoldText,
  //                           elevation: 5,
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(5.0),
  //                           ),
  //                         ),
  //                         onPressed: () async {
  //                           await controller.qrController?.toggleFlash();
  //                         },
  //                         child: FutureBuilder(
  //                           future: controller.qrController?.getFlashStatus(),
  //                           builder: (context, snapshot) {
  //                             return Text(
  //                                 'Flash ${snapshot.data == false ? "Mati" : "Hidup"}',
  //                                 style: TextStyle(fontSize: 8.sp));
  //                           },
  //                         )),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   flex: 2,
  //                   child: Container(
  //                     margin: const EdgeInsets.all(8),
  //                     child: ElevatedButton(
  //                         style: ElevatedButton.styleFrom(
  //                           minimumSize: Size.fromHeight(5.h),
  //                           primary: primaryGoldText,
  //                           elevation: 5,
  //                           shape: RoundedRectangleBorder(
  //                             borderRadius: BorderRadius.circular(5.0),
  //                           ),
  //                         ),
  //                         onPressed: () async {
  //                           await controller.qrController?.flipCamera();
  //                         },
  //                         child: FutureBuilder(
  //                           future: controller.qrController?.getCameraInfo(),
  //                           builder: (context, snapshot) {
  //                             if (snapshot.data != null) {
  //                               return Text(
  //                                   'Kamera ${describeEnum(snapshot.data!) == "back" ? "Belakang" : "Depan"}',
  //                                   style: TextStyle(fontSize: 8.sp));
  //                             } else {
  //                               return Text('loading',
  //                                   style: TextStyle(fontSize: 8.sp));
  //                             }
  //                           },
  //                         )),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   flex: 2,
  //                   child: Container(
  //                     margin: const EdgeInsets.all(8),
  //                     child: ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                         minimumSize: Size.fromHeight(5.h),
  //                         primary: primaryGoldText,
  //                         elevation: 5,
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(5.0),
  //                         ),
  //                       ),
  //                       onPressed: () async {
  //                         await controller.qrController?.pauseCamera();
  //                       },
  //                       child: Text('Pause Kamera',
  //                           style: TextStyle(fontSize: 8.sp)),
  //                     ),
  //                   ),
  //                 ),
  //                 Expanded(
  //                   flex: 2,
  //                   child: Container(
  //                     margin: const EdgeInsets.all(8),
  //                     child: ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                         minimumSize: Size.fromHeight(5.h),
  //                         primary: primaryGoldText,
  //                         elevation: 5,
  //                         shape: RoundedRectangleBorder(
  //                           borderRadius: BorderRadius.circular(5.0),
  //                         ),
  //                       ),
  //                       onPressed: () async {
  //                         await controller.qrController?.resumeCamera();
  //                       },
  //                       child: Text('Play Kamera',
  //                           style: TextStyle(fontSize: 8.sp)),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Container bodyCashier(BuildContext context) {
  //   return Container();
  // }

  // AppBar buildAppBar(BuildContext context) {
  //   return AppBar(
  //     leading: IconButton(
  //       padding: EdgeInsets.only(left: 5.w),
  //       onPressed: () {
  //         Get.back();
  //       },
  //       icon: const Icon(
  //         Icons.arrow_back_ios,
  //         color: Colors.black,
  //       ),
  //     ),
  //     title: Column(
  //       children: [
  //         const Text(
  //           "Scan QR Struk",
  //           style: TextStyle(color: Colors.black),
  //         ),
  //         Text(
  //           "Kasir",
  //           style: Theme.of(context).textTheme.caption,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildQrView(BuildContext context) {
  //   // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
  //   var scanArea = (MediaQuery.of(context).size.width < 400 ||
  //           MediaQuery.of(context).size.height < 400)
  //       ? 150.0
  //       : 300.0;
  //   // To ensure the Scanner view is properly sizes after rotation
  //   // we need to listen for Flutter SizeChanged notification and update controller
  //   return QRView(
  //     key: controller.qrKey,
  //     onQRViewCreated: controller.onQRViewCreated,
  //     overlay: QrScannerOverlayShape(
  //         borderColor: primaryLightGrey,
  //         borderRadius: 10,
  //         borderLength: 30,
  //         borderWidth: 10,
  //         cutOutSize: scanArea),
  //     onPermissionSet: (ctrl, p) =>
  //         controller.onPermissionSet(context, ctrl, p),
  //   );
  // }
}
