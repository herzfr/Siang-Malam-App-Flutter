import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/order/order_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/screens/home/pages/order/component/cart_screen.dart';
import 'package:siangmalam/screens/home/pages/order/component/menu_screen.dart';
import 'package:siangmalam/screens/home/pages/order/component/table_screen.dart';
import 'package:sizer/sizer.dart';

class OrderScreen extends GetView<OrderController> {
  static String routeName = "/order";

  const OrderScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Pesanan';
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(100.0), // here the desired height
          child: AppBar(
            bottom: TabBar(
              controller: controller.tabController,
              tabs: controller.listTab,
            ),
            // title: const Text('Tabs Demo'),
            title: const Text(appTitle),
            backgroundColor: kPrimaryColor,
          )),
      body: TabBarView(
        controller: controller.tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          Center(child: TableScreen()),
          Center(child: MenuScreen()),
          Center(child: OrderCartScreen()),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        padding: EdgeInsets.only(left: 5.w),
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      title: Column(
        children: [
          const Text(
            "Cooming Soons",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "Kasir",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
