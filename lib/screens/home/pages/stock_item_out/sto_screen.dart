import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/sto/sto_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/screens/home/pages/stock_item_out/components/sto_body.dart';
import 'package:siangmalam/screens/home/pages/stock_item_out/components/sto_filter.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StoScreen extends GetView<StoController> {
  const StoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.panelHeightOpen = MediaQuery.of(context).size.height * .50;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundimage),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 237, 248, 243),
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
          panel: const Center(
            child: StoFilterScreen(),
          ),
          body: const StoBody(),
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
        // onChanged: (value) => controller.changeTotalPerPage(10, value),
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
      backgroundColor: primaryYellow,
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
              onSelected: (value) => controller.popupChoose(value),
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
                    child: Text("Keluarkan Bahan"),
                  ),
                ];
              },
            ),
          )
        ],
      ),
    );
  }
}
