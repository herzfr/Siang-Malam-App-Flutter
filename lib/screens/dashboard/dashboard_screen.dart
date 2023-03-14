import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/dashboard/dashboard_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/screens/account/account_screen.dart';
import 'package:siangmalam/screens/home/home_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          extendBody: true,
          backgroundColor: primaryLightGrey,
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(backgroundimagerm),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: IndexedStack(
                index: controller.tabIndex,
                children: const [
                  HomeScreen(),
                  AccountScreen(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.white,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: SvgPicture.asset("assets/icons/Shop Icon.svg",
                        color: primaryDarkGreen),
                    label: "Home"),
                BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    icon: SvgPicture.asset("assets/icons/User Icon.svg",
                        color: primaryDarkGreen),
                    label: "Account"),
              ],
              currentIndex: controller.tabIndex,
              selectedItemColor: primaryGoldText,
              onTap: (int index) {
                controller.changeIndex(index);
              },
            ),
          ),
        );
      },
    );
  }
}
