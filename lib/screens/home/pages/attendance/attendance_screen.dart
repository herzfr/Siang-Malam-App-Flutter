import 'package:flutter/material.dart';
import 'package:siangmalam/screens/home/pages/attendance/components/attendance_body.dart';

/* Created By Dwi Sutrisno */

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AttendanceBody(),
    );
  }
}
