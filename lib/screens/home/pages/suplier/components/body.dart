import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:siangmalam/commons/controllers/suplier/suplier_controller.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/suplier/suplier.dart';
import 'package:sizer/sizer.dart';

class Body extends GetView<SuplierController> {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Obx(() {
              return PagedListView<int, ListSuplier>.separated(
                pagingController: controller.pagingController.value,
                padding: EdgeInsets.all(1.sp),
                separatorBuilder: (context, index) => SizedBox(
                  height: 0.5.h,
                ),
                shrinkWrap: true,
                builderDelegate: PagedChildBuilderDelegate<ListSuplier>(
                  itemBuilder: (context, suplier, index) => ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 13.h,
                      maxHeight: 17.h,
                    ),
                    child: Card(
                      elevation: 2,
                      shadowColor: Colors.grey,
                      // color: Color(0xFFE9E9E9),
                      margin: EdgeInsets.all(1.sp),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        dense: true,
                        leading: Icon(
                          Icons.workspaces_sharp,
                          color: primaryDarkGreen,
                          size: 20.sp,
                        ),
                        title: Text(
                          suplier.name.toString(),
                          style: GoogleFonts.raleway(
                              fontSize: 11.sp,
                              color: primaryDarkGreen,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 7,
                                  child: Text(
                                    suplier.description ?? '',
                                    style: GoogleFonts.raleway(
                                        fontSize: 9.sp,
                                        color: primaryDarkGreen,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 0.5.w,
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    suplier.phone ?? '',
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.raleway(
                                        fontSize: 9.sp,
                                        color: primaryDarkGreen,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.email,
                                  color: primaryGoldText,
                                  size: 14.sp,
                                ),
                                SizedBox(
                                  width: 0.5.w,
                                ),
                                Expanded(
                                  child: Text(
                                    suplier.email ?? '-',
                                    style: GoogleFonts.raleway(
                                        fontSize: 10.sp,
                                        color: primaryDarkGreen,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: primaryGoldText,
                                  size: 14.sp,
                                ),
                                SizedBox(
                                  width: 0.5.w,
                                ),
                                Expanded(
                                  child: Text(
                                    "${suplier.address1}, ${suplier.address2}, ${suplier.address3}",
                                    style: GoogleFonts.raleway(
                                        fontSize: 9.sp,
                                        color: primaryDarkGreen,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        onTap: () {
                          controller.getDetail(index);
                          Get.toNamed(RouteName.suplierFormScreen)?.then(
                              (value) => controller.logData(value ?? false));
                          // showBottomSheet(context, index, stockproduct);
                        },
                      ),
                    ),
                  ),
                ),
              );

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

  // dynamic showBottomSheet(
  //     BuildContext context, int index, ListSuplier stockproduct) {
  //   return showModalBottomSheet<void>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return StockProductForm();
  //         // return Container(
  //         //     height: 100.h,
  //         //     color: Colors.amber,
  //         //     child: Center(
  //         //         child: Column(
  //         //       mainAxisAlignment: MainAxisAlignment.center,
  //         //       mainAxisSize: MainAxisSize.min,
  //         //       children: <Widget>[
  //         //         Text(controller.pagingController.value.itemList
  //         //                 ?.elementAt(index)
  //         //                 .product!
  //         //                 .name ??
  //         //             ''),
  //         //         ElevatedButton(
  //         //           child: const Text('Close BottomSheet'),
  //         //           onPressed: () => Navigator.pop(context),
  //         //         )
  //         //       ],
  //         //     )));
  //       });
  // }
}
