import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/splash/splash_controller.dart';
import 'package:siangmalam/commons/size_config.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:sizer/sizer.dart';

/*Created By Dwi Sutrisno*/

class SplashScreen extends GetView<SplashController> {
  
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context); // call in starting screen
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/bg.png"),
          fit: BoxFit.cover,
        )),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Spacer(),
                Image.asset(
                  'assets/images/sm_logo.png',
                  width: 50.0.w,
                ),
                SizedBox(
                  height: 2.h,
                ),
                Obx(() => Text(
                      controller.statusTxt.value,
                      style: const TextStyle(color: mtGrey700),
                    )),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
