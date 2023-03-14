import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/printer/printer_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/screens/home/pages/printer/components/body.dart';
import 'package:sizer/sizer.dart';

class PrinterScreen extends GetView<PrinterController> {
  static String routeName = "/stockitem";
  const PrinterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.amber,
        //   onPressed: () async {
        //     await controller.refreshList();
        //   },
        //   child: const Icon(Icons.refresh, color: Colors.white),
        // ),
        appBar: buildAppBar(context),
        body: const Body());
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        backgroundColor: primaryYellow,
        leading: IconButton(
          padding: EdgeInsets.only(left: 2.w),
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Container(
          color: Colors.transparent,
          child: const Text(
            "Printer",
            textScaleFactor: 1.3,
            style: TextStyle(color: primaryGrey),
          ),
        ));
  }
}
