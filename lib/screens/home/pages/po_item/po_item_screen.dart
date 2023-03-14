import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/po/po_item_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/screens/home/pages/po_item/components/body.dart';
import 'package:siangmalam/screens/home/pages/po_item/components/filter_screen.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PoItemScreen extends GetView<PoItemController> {
  static String routeName = "/po-item";
  const PoItemScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.panelHeightOpen = MediaQuery.of(context).size.height * .66;
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
          preferredSize: const Size.fromHeight(60.0), // here the desired height
          child: buildAppBar(context),
        ),
        // body: const Body(),
        body: SlidingUpPanel(
          maxHeight: controller.panelHeightOpen,
          minHeight: controller.panelHeightClosed,
          parallaxEnabled: true,
          parallaxOffset: .5,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
          panel: const Center(
            child: FilterScreen(),
          ),
          body: const Body(),
        ),
      ),
    );
  }

  Container searchField(BuildContext context) {
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
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      backgroundColor: primaryGoldText,
      elevation: 2,
      leading: IconButton(
        padding: EdgeInsets.only(left: 5.w),
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
          Expanded(
            child: PopupMenuButton<dynamic>(
              initialValue: controller.size,
              icon: const Icon(Icons.more_vert, color: Colors.white),
              onSelected: (value) => controller.changeTotalPerPage(value),
              itemBuilder: (context) {
                return [
                  const CheckedPopupMenuItem(
                    value: 0,
                    // checked: controller.size.value == 15,
                    child: Text("Refresh Data"),
                  ),
                  const CheckedPopupMenuItem(
                    value: 1,
                    // checked: controller.size.value == 15,
                    child: Text("Buat daftar belanja"),
                  ),
                  // CheckedPopupMenuItem(
                  //   value: 25,
                  //   checked: controller.size.value == 25,
                  //   child: const Text("Per 25 Item"),
                  // ),
                  // CheckedPopupMenuItem(
                  //   value: 50,
                  //   checked: controller.size.value == 50,
                  //   child: const Text("Per 50 Item"),
                  // )
                ];
              },
            ),
          )
        ],
      ),
    );
  }
}
