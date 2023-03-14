import 'package:flutter/material.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/screens/account/pages/device_info/component/device_info_form.dart';
import 'package:siangmalam/widgets/custom_back_app_bar.dart';
import 'package:sizer/sizer.dart';

class DeviceInfoScreen extends StatelessWidget {
  const DeviceInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(minHeight: 100.h),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(backgroundimage),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomBackAppBar(),
            SizedBox(
              height: 2.5.h,
            ),
            Text(
              "Device Info",
              style: TextStyle(fontSize: 18.0.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 3.h,
            ),
            DeviceInfoForm()
          ],
        ),
      ),
    ));
  }
}
