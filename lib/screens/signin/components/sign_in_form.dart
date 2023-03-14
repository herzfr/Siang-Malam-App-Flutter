import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/icons.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:form_validator/form_validator.dart';
import 'package:siangmalam/commons/size_config.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:siangmalam/commons/custom_style.dart';
import 'package:siangmalam/widgets/custom_button.dart';
import 'package:siangmalam/commons/functions/debouncer.dart';
import 'package:siangmalam/commons/controllers/signin/signin_controller.dart';

//Created By Dwi S - Januari 2021

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  late String username = '', password;
  bool _obscureText = true;
  IconData passIcon = Icons.visibility_off;

  final signInController = Get.put(SignInController());
  final debouncer = Debouncer(milliseconds: 1500);

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.0.w),
        child: Column(
          children: [
            CustomInputField(
              hint: userNameInputLabel,
              label: userNameInputLabel,
              enable: true,
              icon: Icons.account_box,
              node: node,
              inputType: TextInputType.text,
              dataInstance: (String? val) {
                username = val ?? '';
              },
              validationBuilder:
                  ValidationBuilder().minLength(3, userNameInputVldMsg).build(),
            ),
            SizedBox(
              height: 2.5.h,
            ),
            buildPassForm(
                passwordInputHint, passwordInputLabel, iconLock, true),
            SizedBox(
              height: 4.h,
            ),
            CustomButton(
              text: loginBtnLabel,
              icon: Icons.keyboard_arrow_right,
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  signInController.signIn.value.username = username;
                  signInController.signIn.value.password = password;

                  debouncer.run(() {
                    signInController.sendLoginRequest();
                  });
                }
              },
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }

  TextFormField buildPassForm(
      String hint, String label, String icon, bool hide) {
    return TextFormField(
      textInputAction: TextInputAction.go,
      onSaved: (passValue) => password = passValue!.trim(),
      validator: ValidationBuilder().minLength(3, passwordInputVldMsg).build(),
      obscureText: _obscureText,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          border: outlineInputBorder,
          hintText: hint,
          labelText: label,
          labelStyle: const TextStyle(color: primaryGrey),
          contentPadding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(inputHorizontalPadding),
            vertical: getProportionateScreenHeight(inputVerticalPadding),
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              setState(() {
                _toggle();
              });
            },
            child: Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: Icon(
                passIcon,
                color: primaryGrey,
                size: 6.5.w,
              ),
            ),
          )),
    );
  }

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
      passIcon = _obscureText ? Icons.visibility_off : Icons.visibility;
    });
  }
}
