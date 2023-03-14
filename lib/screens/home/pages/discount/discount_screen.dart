import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siangmalam/commons/controllers/discount/discount_controller.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/enums.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'components/discount_body.dart';

class DiscountScreen extends GetView<DiscountController> {
  const DiscountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.panelHeightOpen = MediaQuery.of(context).size.height * .30;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundimagerm),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: const Color.fromARGB(0, 237, 248, 243),
          appBar: PreferredSize(
            preferredSize:
                const Size.fromHeight(60.0), // here the desired height
            child: buildAppBar(context),
          ),
          // body: const Body(),
          body: Obx(() => controller.whoIs.value == 'ADMIN'
              ? getSearchControllAdmin()
              : const DiscountBody()),
          bottomNavigationBar: controller.whoIs.value == 'MANAGER'
              ? getbottomNavigationBar()
              : null),
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
        onSubmitted: (value) => controller.searchDataGeneral(),
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
      backgroundColor: primaryDarkGreen,
      elevation: 2,
      leading: IconButton(
        padding: EdgeInsets.only(left: 5.w),
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: primaryGoldText,
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: searchField(context),
          ),
          SizedBox(height: 2.5.h),
          PopupMenuButton<dynamic>(
            // initialValue: controller.size,
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) => controller.changeTotalPerPage(value),
            itemBuilder: (context) {
              return List<PopupMenuEntry<Sortir>>.generate(
                Sortir.values.length,
                (int index) {
                  return PopupMenuItem(
                    value: Sortir.values[index],
                    child: AnimatedBuilder(
                      child: Text(Sortir.values[index].toString()),
                      animation: controller.selectedItemSortBy.value,
                      builder: (BuildContext context, Widget? child) {
                        return RadioListTile<Sortir>(
                          value: Sortir.values[index],
                          groupValue: controller.selectedItemSortBy.value.value,
                          title: child,
                          onChanged: (value) {
                            if (value == Sortir.terbaru) {
                              controller.sortBy.value = 'desc';
                              controller.selectedItemSortBy.value.value =
                                  value!;

                              controller.refreshAscDesc();
                            } else {
                              controller.sortBy.value = 'asc';
                              controller.selectedItemSortBy.value.value =
                                  value!;
                              controller.refreshAscDesc();
                            }
                          },
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  getbottomNavigationBar() {
    return Material(
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SizedBox(
            height: kToolbarHeight,
            width: double.infinity,
            child: getSearchControll()),
      ),
    );
  }

  getSearchControll() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: DropdownButtonFormField<int>(
            // key: controller.dropStatus,
            items: controller.subbranchDropDownManager,
            value: controller.subBranchId,
            decoration: CustomFormWidget.customInputDecoration('', 'Cabang'),
            onChanged: (value) {
              if (value != null) {
                controller.subBranchId = value;
                controller.searchDataGeneral();
              }
            },
          ),
        ),
        Expanded(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(5.sp),
              child: OutlinedButton(
                style: ElevatedButton.styleFrom(
                  primary: primaryGoldText,
                  side: const BorderSide(width: 0.0, color: Colors.transparent),
                ),
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 14.sp,
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Diskon',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                            fontSize: 10.sp,
                            color: Colors.white,
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  controller.setNewDicount();
                  Get.toNamed(RouteName.discountFormScreen)
                      // ignore: avoid_print
                      ?.then((value) =>
                          value ? controller.clearValueSearch() : null);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  getSearchControllAdmin() {
    return SlidingUpPanel(
      maxHeight: controller.panelHeightOpen,
      minHeight: controller.panelHeightClosed,
      parallaxEnabled: true,
      parallaxOffset: .5,
      panel: const Center(
        child: FilterControllDiscount(),
      ),
      body: const DiscountBody(),
    );
  }
}

class FilterControllDiscount extends GetView<DiscountController> {
  const FilterControllDiscount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.arrow_drop_up,
              color: primaryGrey,
            ),
            const SizedBox(
              height: 5,
            ),
            // DropdownButtonFormField<int>(
            //   // key: controller.dropStatus,
            //   items: controller.branchDropDown,
            //   value: controller.branchId,
            //   decoration: CustomFormWidget.customInputDecoration('', 'Cabang'),
            //   onChanged: (value) {
            //     if (value != null) {
            //       if (value > 0) {
            //         controller.branchId = value;
            //         controller.getDataSubBranch(value);
            //       } else {
            //         controller.branchId = value;
            //         controller.getDataSubBranch(value);
            //         controller.searchDataAdmin();
            //       }
            //     } else {
            //       controller.clearFilterAll();
            //     }
            //   },
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // DropdownButtonFormField<int>(
            //   // key: controller.dropStatus,
            //   items: controller.subbranchDropDown,
            //   value: controller.subBranchId,
            //   decoration:
            //       CustomFormWidget.customInputDecoration('', 'Anak Cabang'),
            //   onChanged: (value) {
            //     controller.subBranchId = value!;
            //     controller.searchDataAdmin();
            //   },
            // ),
            Expanded(
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      primary: primaryBlue,
                      side: const BorderSide(
                          width: 0.0, color: Colors.transparent),
                    ),
                    child: Stack(
                      children: const [
                        Align(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Diskon',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      controller.setNewDicount();
                      Get.toNamed(RouteName.discountFormScreen)?.then((value) =>
                          value ? controller.clearValueSearch() : null);
                    },
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
