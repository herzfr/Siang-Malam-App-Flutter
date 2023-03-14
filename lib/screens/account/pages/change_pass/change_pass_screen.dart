import 'package:siangmalam/screens/account/pages/change_pass/components/change_pass_form.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/widgets/custom_back_app_bar.dart';

/* Created By Dwi Sutrisno */

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

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
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomBackAppBar(),
              SizedBox(
                height: 2.5.h,
              ),
              Text(
                "Ganti Password",
                style: TextStyle(fontSize: 18.0.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3.h,
              ),
              const ChangePassForm()
            ],
          ),
        ),
      ),
    );
  }
}
