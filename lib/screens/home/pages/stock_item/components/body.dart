import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:siangmalam/commons/controllers/item/stock_item_controller.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/product/stock_item.dart';
import 'package:sizer/sizer.dart';

class Body extends GetView<StockItemController> {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: Column(
        children: <Widget>[
          // searchField(),
          Expanded(
            flex: 1,
            child: Obx(() {
              return PagedListView<int, ListStockItem>.separated(
                  pagingController: controller.pagingController.value,
                  padding: EdgeInsets.all(1.sp),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 0.1.h,
                      ),
                  shrinkWrap: true,
                  builderDelegate: PagedChildBuilderDelegate<ListStockItem>(
                    itemBuilder: (context, stockItems, index) => Card(
                      elevation: 2,
                      shadowColor: Colors.green,
                      // color: Color(0xFFE9E9E9),
                      margin: EdgeInsets.all(1.sp),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: GestureDetector(
                          child: ListTile(
                        leading: Icon(
                          Icons.arrow_right,
                          color: primaryGoldText,
                          size: 40.sp,
                        ),
                        title: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              stockItems.items!.name!,
                              style: GoogleFonts.raleway(
                                  fontSize: 12.sp,
                                  color: primaryDarkGreen,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Text(
                              stockItems.quantity!.toString() + " Stok",
                              style: GoogleFonts.raleway(
                                  fontSize: 12.sp,
                                  color: primaryDarkGreen,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          stockItems.warehouse?.name ?? 'Tidak ada Gudang',
                          style: GoogleFonts.raleway(
                              fontSize: 9.sp,
                              color: primaryGoldText,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          controller.getDetailStockProduct(index);
                          Get.toNamed(RouteName.stockItemTransferScreen)?.then(
                              (value) => controller.logData(value ?? false));
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
  }
}
