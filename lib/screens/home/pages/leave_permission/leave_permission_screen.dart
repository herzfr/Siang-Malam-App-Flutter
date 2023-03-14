import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/home/leave_permission_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/screens/home/pages/leave_permission/components/leave_permission_body.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/widgets/custom_back_app_bar.dart';

/*Created By Dwi Sutrisno*/

class LeavePermissionScreen extends GetView<LeavePermissionController> {
  const LeavePermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarWithTitle(
        backIcon: Icons.chevron_left,
        title: "Izin",
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundimage),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: const LeavePermissionBody(),
      ),
      floatingActionButton: Visibility(
        visible: controller.showFloating.value,
        child: FloatingActionButton.extended(
          backgroundColor: primaryYellow,
          elevation: 10,
          onPressed: () {},
          label: const Text("Buat Izin", style: TextStyle(color: whiteBg),),
        ),
      ),
    );
  }
}
