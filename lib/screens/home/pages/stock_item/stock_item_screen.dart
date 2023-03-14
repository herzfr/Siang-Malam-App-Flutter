import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/item/stock_item_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/screens/home/pages/stock_item/components/body.dart';
import 'package:sizer/sizer.dart';

class StockItemScreen extends StatelessWidget {
  static String routeName = "/stockitem";
  const StockItemScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundimagerm),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(7.h), // here the desired height
          child: buildAppBar(context),
        ),
        body: const Body(),
        // bottomNavigationBar: const CheckoutCard(),
      ),
    );
  }

  Container searchField(BuildContext context) {
    StockItemController controller = Get.find();
    return Container(
      width: MediaQuery.of(context).size.width * .66,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          // color: primaryGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        textInputAction: TextInputAction.search,
        controller: controller.textFieldController.value,
        // onChanged: (value) => _controller.changeTotalPerPage(10, value),
        onSubmitted: (value) => controller.searchData(),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Cari...",
          filled: true,
          suffixIcon: IconButton(
              onPressed: () {
                controller.clearValueSearch();
              },
              icon: const Icon(Icons.clear, color: Color(0xFFDFC012))),
          // icon: const Icon(Icons.clear),
          prefixIcon: const Icon(Icons.search, color: Color(0xFFDFC012)),
          contentPadding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    StockItemController controller = Get.find();
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      backgroundColor: primaryDarkGreen,
      elevation: 2,
      leading: IconButton(
        padding: EdgeInsets.only(left: 1.w),
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          searchField(context),
          SizedBox(height: 2.5.h),
          PopupMenuButton<dynamic>(
              initialValue: controller.size,
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) => controller.changeTotalPerPage(value),
              itemBuilder: (context) {
                return [
                  CheckedPopupMenuItem(
                    value: 15,
                    checked: controller.size.value == 15,
                    child: const Text("Per 15 Produk"),
                  ),
                  CheckedPopupMenuItem(
                    value: 25,
                    checked: controller.size.value == 25,
                    child: const Text("Per 25 Produk"),
                  ),
                  CheckedPopupMenuItem(
                    value: 50,
                    checked: controller.size.value == 50,
                    child: const Text("Per 50 Produk"),
                  )
                ];
              })
        ],
      ),
    );
  }
}
