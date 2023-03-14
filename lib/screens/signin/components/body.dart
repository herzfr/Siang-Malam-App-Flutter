import 'package:flutter/material.dart';
import 'package:siangmalam/commons/size_config.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/screens/signin/components/sign_in_form.dart';
import 'package:sizer/sizer.dart';

/*Created By Dwi Sutrisno*/

class SignInBody extends StatefulWidget {
  const SignInBody({Key? key}) : super(key: key);

  @override
  _SignInBodyState createState() => _SignInBodyState();
}

class _SignInBodyState extends State<SignInBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.screenHeight * 0.04,
                ),
                Text(
                  headerTitle,
                  style:
                      TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                Text(
                  subHeaderTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.0.sp),
                ),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
                const SignForm(),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.08,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
