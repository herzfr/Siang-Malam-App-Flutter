import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/profile/account_controller.dart';
import 'package:siangmalam/screens/account/components/body.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

/* Created By Dwi Sutrisno */

class AccountScreen extends GetView<AccountController> {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0x00ffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            child: Text(
              "Akun",
              style: TextStyle(fontSize: 20.sp),
            ),
          ),
          SizedBox(height: 5.h),
          const Expanded(
            child: Body(),
          )
        ],
      ),
    );
  }
}
