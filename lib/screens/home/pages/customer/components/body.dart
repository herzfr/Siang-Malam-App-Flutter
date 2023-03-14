import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:siangmalam/commons/controllers/customer/customer_controller.dart';
import 'package:siangmalam/commons/routes/routes_name.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/models/customer/customer.dart';
import 'package:sizer/sizer.dart';

class Body extends GetView<CustomerController> {
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
              return PagedListView<int, ListCustomer>.separated(
                pagingController: controller.pagingController.value,
                padding: const EdgeInsets.all(1),
                separatorBuilder: (context, index) => SizedBox(
                  height: 0.5.h,
                ),
                shrinkWrap: true,
                builderDelegate: PagedChildBuilderDelegate<ListCustomer>(
                  itemBuilder: (context, customer, index) => ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 15.h,
                      maxHeight: 20.h,
                    ),
                    child: Card(
                      elevation: 2,
                      shadowColor: Colors.grey,
                      // color: Color(0xFFE9E9E9),
                      margin: const EdgeInsets.all(1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        dense: true,
                        leading: Icon(
                          Icons.people,
                          color: primaryDarkGreen,
                          size: 20.sp,
                        ),
                        title: Text(
                          customer.name.toString(),
                          style: GoogleFonts.raleway(
                              fontSize: 11.sp,
                              color: primaryDarkGreen,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: primaryGoldText,
                                  size: 14.sp,
                                ),
                                SizedBox(
                                  width: 0.5.w,
                                ),
                                Text(
                                  customer.phone ?? '-',
                                  style: GoogleFonts.raleway(
                                      fontSize: 10.sp,
                                      color: primaryDarkGreen,
                                      fontWeight: FontWeight.bold),
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
                                    customer.email ?? '-',
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
                                    "${customer.address1}, ${customer.address2}, ${customer.address3}",
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
                          Get.toNamed(RouteName.customerFormScreen)?.then(
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
}
