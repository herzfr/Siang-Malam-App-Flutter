// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:siangmalam/commons/controllers/product/stock_product_controller.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/product/stock_product.dart';
import 'package:siangmalam/screens/home/pages/stock_product/components/stock_product_form.dart';
import 'package:sizer/sizer.dart';

class Body extends GetView<StockProductController> {
  Body({Key? key}) : super(key: key);
  // final StockProductController _controller = Get.put(StockProductController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 1.h, bottom: 1.h),
            decoration: const BoxDecoration(
                color: primaryDarkGreen,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.only(left: 2.5.w),
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
                Container(
                  width: 70.w,
                  height: 5.h,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    controller: controller.textFieldController.value,
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
                          icon:
                              const Icon(Icons.clear, color: primaryGoldText)),
                      prefixIcon:
                          const Icon(Icons.search, color: primaryGoldText),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 1.0.h),
                    ),
                  ),
                ),
                PopupMenuButton<dynamic>(
                    // initialValue: _controller.size,
                    icon: const Icon(Icons.more_vert, color: Colors.white),
                    onSelected: (value) => controller.changeTotalPerPage(value),
                    itemBuilder: (context) {
                      return [
                        CheckedPopupMenuItem(
                          value: 15,
                          checked: controller.size == 15,
                          child: const Text("Per 15"),
                        ),
                        CheckedPopupMenuItem(
                          value: 25,
                          checked: controller.size == 25,
                          child: const Text("Per 25"),
                        ),
                        CheckedPopupMenuItem(
                          value: 50,
                          checked: controller.size == 50,
                          child: const Text("Per 50"),
                        )
                      ];
                    })
              ],
            ),
          ),

          Expanded(
            flex: 1,
            child: Obx(() {
              return PagedListView<int, ListProducts>.separated(
                  pagingController: controller.pagingController.value,
                  padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 0.5.h,
                      ),
                  shrinkWrap: true,
                  builderDelegate: PagedChildBuilderDelegate<ListProducts>(
                    itemBuilder: (context, stockproduct, index) => Card(
                      elevation: 2,
                      shadowColor: Colors.grey,
                      // color: Color(0xFFE9E9E9),
                      margin: EdgeInsets.all(1.sp),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: GestureDetector(
                          child: ListTile(
                        leading: Icon(
                          Icons.production_quantity_limits_rounded,
                          color: primaryGoldText,
                          size: 25.sp,
                        ),
                        title: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              stockproduct.product!.name!.toString(),
                              style: GoogleFonts.raleway(
                                  fontSize: 12.sp,
                                  color: primaryDarkGreen,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Text(
                              stockproduct.quantity!.toString() + " Stok",
                              style: GoogleFonts.raleway(
                                  fontSize: 12.sp,
                                  color: primaryDarkGreen,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          stockproduct.warehouse?.name ?? 'Tidak ada Gudang',
                          style: GoogleFonts.raleway(
                              fontSize: 9.sp,
                              color: primaryGoldText,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          controller.getDetailStockProduct(index);
                          Get.toNamed(RouteName.stockProductTransferScreen)
                              ?.then((value) =>
                                  controller.logData(value ?? false));
                          // showBottomSheet(context, index, stockproduct);
                        },
                      )),
                    ),
                  ));

              // );
            }),
          ),
          // Spacer(),
        ],
      ),
    );
    // return Padding(
    //   padding: EdgeInsets.symmetric(horizontal: 5.w),

    // );
  }

  dynamic showBottomSheet(
      BuildContext context, int index, ListProducts stockproduct) {
    return showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return StockProductForm();
          // return Container(
          //     height: 100.h,
          //     color: Colors.amber,
          //     child: Center(
          //         child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       mainAxisSize: MainAxisSize.min,
          //       children: <Widget>[
          //         Text(controller.pagingController.value.itemList
          //                 ?.elementAt(index)
          //                 .product!
          //                 .name ??
          //             ''),
          //         ElevatedButton(
          //           child: const Text('Close BottomSheet'),
          //           onPressed: () => Navigator.pop(context),
          //         )
          //       ],
          //     )));
        });
  }

  // ListView listView() {
  //   return ListView.builder(
  //       // controller: sController.msgScroll,
  //       shrinkWrap: true,
  //       itemCount: controller.stockProduct.value.pageable!.pageSize,
  //       itemBuilder: (BuildContext context, int index) {
  //         return ListTile(
  //             leading: const Icon(Icons.list),
  //             trailing: Text(
  //               '${controller.stockProduct.value.listProduct![index].quantity}',
  //               style: const TextStyle(color: Colors.green, fontSize: 15),
  //             ),
  //             title: Text(
  //                 "${controller.stockProduct.value.listProduct![index].product?.name}"));
  //       });
  // }
}
