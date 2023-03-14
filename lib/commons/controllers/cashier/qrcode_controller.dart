// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeController extends GetxController {
  // var log = Logger();
  // Barcode? result;
  // QRViewController? qrController;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  String localFilePath = 'assets/sounds/barcode-effect.mp3';

  // @override
  // void onInit() {}

  // @override
  // void reassemble() {
  //   this.reassemble();
  //   if (Platform.isAndroid) {
  //     // qrController!.pauseCamera();
  //   }
  //   // qrController!.resumeCamera();
  // }

  // void onQRViewCreated(QRViewController controller) {
  //   this.qrController = controller;
  //   var i = 0;
  //   controller.scannedDataStream.listen((scanData) async {
  //     result = scanData;
  //     // log.d(result!.code);
  //     i++;
  //     if (i == 1) {
  //       Get.back(result: result!.code);
  //     }
  //   });
  // }

  // void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
  //   // log.d('${DateTime.now().toIso8601String()}_onPermissionSet $p');
  //   if (!p) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('no Permission')),
  //     );
  //   }
  // }

  // @override
  // void onClose() {
  //   // qrController?.dispose();
  //   super.onClose();
  // }
}
