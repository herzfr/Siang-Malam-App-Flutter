import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/screens/signin/components/body.dart';

/* Created By Dwi Sutrisno */

class SignInScreen extends StatelessWidget {
  static String routeName = signInRoutes;

  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(backgroundimage),
          fit: BoxFit.cover,
        )),
        child: const Center(
          child: DoubleBackToCloseApp(
            snackBar: SnackBar(content: Text(tapBackAgainMsg)),
            child: SignInBody(),
          ),
        ),
      ),
    );
  }
}
