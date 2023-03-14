import 'package:flutter/material.dart';
// import 'package:siangmalam/constans/enums.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/screens/home/components/body.dart';
// import 'package:siangmalam/widgets/custom_bottom_nav_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

/* Created By Dwi Sutrisno */

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBody: true,
      backgroundColor: Color(0x00ffffff),
      body: DoubleBackToCloseApp(
        snackBar: SnackBar(content: Text(tapBackAgainMsg)),
        child: Body(),
      ),
      // bottomNavigationBar:
      //     const CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
