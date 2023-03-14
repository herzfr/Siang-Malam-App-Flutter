import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/widgets/custom_back_app_bar.dart';
import 'package:siangmalam/commons/controllers/home/attendance_history_controller.dart';
import 'package:siangmalam/screens/home/pages/attendance/pages/components/attendance_history_body.dart';

/* Created By Dwi Sutrisno */

class AttendanceHistoryScreen extends GetView<AttendanceHistoryController> {
  const AttendanceHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarWithTitle(
        backIcon: Icons.chevron_left,
        title: "Riwayat Absensi",
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundimage),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: const AttendanceHistoryBody(),
      ),
    );
  }
}
