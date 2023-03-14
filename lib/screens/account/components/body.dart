import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/profile/account_controller.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'profile_pic.dart';
import 'account_menu.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

// Created By Dwi Sutrisno

class Body extends GetView<AccountController> {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 3.h),
          AccountMenu(
            text: "Profile",
            icon: "assets/icons/User Icon.svg",
            press: () => {Get.toNamed(RouteName.accountProfileScreen)},
          ),
          // AccountMenu(
          //   text: "Notifications",
          //   icon: "assets/icons/Bell.svg",
          //   press: () {},
          // ),
          AccountMenu(
            text: "Settings",
            icon: "assets/icons/Settings.svg",
            press: () {
              Get.bottomSheet(
                  SizedBox(
                    height: 27.h,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.w),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.vpn_key),
                            title: const Text('Ganti Sandi'),
                            onTap: () {
                              Get.back();
                              Get.toNamed(RouteName.accountChangePass);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.print),
                            title: const Text('Printer'),
                            onTap: () {
                              Get.back();
                              Get.toNamed(RouteName.printerScreen);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.info),
                            title: const Text('Device Info'),
                            onTap: () {
                              Get.back();
                              Get.toNamed(RouteName.deviceInfoScreen);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 20.0,
                  enableDrag: true,
                  backgroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  )));
            },
          ),
          AccountMenu(
            text: "Log Out",
            icon: "assets/icons/Log out.svg",
            press: () {
              controller.logout();
            },
          ),
        ],
      ),
    );
  }
}
