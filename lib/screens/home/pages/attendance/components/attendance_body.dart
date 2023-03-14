import 'package:flutter/material.dart';
import 'package:siangmalam/screens/home/pages/attendance/components/attendance_map.dart';
import 'package:siangmalam/screens/home/pages/attendance/components/attendance_panel.dart';
import 'package:siangmalam/screens/home/pages/attendance/components/attendance_app_bar.dart';

/* Created By Dwi Sutrisno */

class AttendanceBody extends StatelessWidget {
  const AttendanceBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        AttendanceMap(),
        AttendanceAppBar(),
        AttendancePanel(),
      ],
    );
  }
}

