import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:siangmalam/commons/controllers/product/spa_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/product/stock_kitchen.dart';
import 'package:siangmalam/screens/home/pages/spa/component/spa_date_filter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sizer/sizer.dart';

class SpaScreen extends GetView<SpaController> {
  static String routeName = " /stock-product-adjustment";
  const SpaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.panelHeightOpen = 40.h;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(context),
      body: SlidingUpPanel(
        maxHeight: controller.panelHeightOpen,
        minHeight: controller.panelHeightClosed,
        controller: controller.pcs,
        parallaxEnabled: true,
        parallaxOffset: .10,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        panel: Center(
          child: filter(context),
        ),
        body: body(context),
      ),
    );
  }

  Container body(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Obx(() => page(context))));
  }

  Container page(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Obx(
            () => controller.adList.isNotEmpty
                ? transferList()
                : Center(
                    child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Daftar produk masuk kosong,\n Cari kata kunci lain.',
                      textAlign: TextAlign.center,
                    ),
                  )),
          ),
          if (controller.loadingPageAdjustList.isTrue) ...[
            Positioned(
              left: 0,
              bottom: 10.h,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 80,
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
          ],
        ],
      ),
    );
  }

  ListView transferList() {
    return ListView.builder(
        controller: controller.scrollController.value,
        itemCount: controller.adList.length +
            (controller.allLoadedPageAdjustList.value ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < controller.adList.length) {
            return Obx(() => initListCard(context, index));
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Center(
                child: Text("Tidak ada lagi daftar stok masuk",
                    style: TextStyle(
                      fontSize: 7.sp,
                    )),
              ),
            );
          }
        });
  }

  Card initListCard(BuildContext ctx, int idx) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: Padding(
          padding: EdgeInsets.all(5.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.inventory,
                  color: primaryDarkGreen,
                ),
                title: Text(
                  controller.adList.elementAt(idx).note ?? '-',
                  style: GoogleFonts.raleway(
                      fontSize: 12.sp,
                      color: primaryDarkGreen,
                      letterSpacing: 1,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  controller.adList.elementAt(idx).name ?? '-',
                  style: GoogleFonts.raleway(
                      fontSize: 10.sp,
                      color: primaryDarkGreen,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal),
                ),
                trailing: Text(
                  controller.converDateMillisToString(
                          controller.adList.elementAt(idx).createdAt ?? 0) ??
                      '-',
                  style: GoogleFonts.raleway(
                      fontSize: 10.sp,
                      color: primaryDarkGreen,
                      letterSpacing: 1,
                      fontWeight: FontWeight.normal),
                ),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Container(
                color: Colors.grey,
                height: 40.h,
                child: Padding(
                    padding: EdgeInsets.all(5.sp),
                    child: ListView.builder(
                        itemCount:
                            controller.adList.elementAt(idx).items?.length ?? 0,
                        itemBuilder: (context, index) {
                          List<ProdAdjs> items =
                              controller.adList.elementAt(idx).items ?? [];
                          if (items.isNotEmpty) {
                            return Card(
                              child: ListTile(
                                leading: const Icon(Icons.insert_link),
                                trailing: Text(
                                  '${items[index].stockQuantity} ${items[index].unit}',
                                  style: GoogleFonts.raleway(
                                      fontSize: 10.sp,
                                      color: primaryDarkGreen,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold),
                                ),
                                title: Text(
                                  items[index].productName ?? '-',
                                  style: GoogleFonts.raleway(
                                      fontSize: 10.sp,
                                      color: primaryGoldText,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                    'Penyesuaian ${items[index].adjustQuantity} ${items[index].unit}'),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        })),
              )
            ],
          )),
    );
  }

  Container filter(BuildContext context) {
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
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              const SpaFilterPanel(),
            ]));
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
          color: Colors.white,
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 9,
            child: searchField(context),
          ),
          // SizedBox(height: 2.5.h),
          Expanded(
            flex: 1,
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
                    child: Text("Masukan Produk"),
                  ),
                ];
              },
            ),
          )
        ],
      ),
    );
  }

  Container searchField(BuildContext context) {
    return Container(
      // width: MediaQuery.of(context).size.width * .66,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          // color: primaryGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        textInputAction: TextInputAction.search,
        controller: controller.textFieldSearch.value,
        onChanged: (value) => {controller.search.value = value},
        onSubmitted: (value) => {controller.oneShot()},
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: "Cari...",
          filled: true,
          suffixIcon: IconButton(
              onPressed: () {
                controller.textFieldSearch.value.clear();
                controller.search.value = '';
                controller.oneShot();
              },
              icon: const Icon(Icons.clear, color: Color(0xFFDFC012))),
          // icon: const Icon(Icons.clear),
          prefixIcon: const Icon(Icons.search, color: Color(0xFFDFC012)),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 2.h, vertical: 1.5.h),
        ),
      ),
    );
  }
}
