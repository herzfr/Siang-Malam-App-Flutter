import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:siangmalam/commons/controllers/sto/sto_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/stok-item-out/response/stock_item_out.dart';
import 'package:sizer/sizer.dart';
import 'dart:ui' as ui;

class StoBody extends GetView<StoController> {
  const StoBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 1.w, right: 1.w, bottom: controller.panelHeightClosed + 12.h),
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Obx(() {
              return PagedListView<int, StockItemOutList>.separated(
                pagingController: controller.pagingController.value,
                // padding: const EdgeInsets.all(0),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 0,
                ),
                shrinkWrap: true,
                builderDelegate: PagedChildBuilderDelegate<StockItemOutList>(
                  itemBuilder: (context, stolist, index) => Center(
                    child: Card(
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(
                                Icons.production_quantity_limits,
                                color: Colors.white),
                            title: Text(
                              stolist.note ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2C2C2C)),
                            ),
                            subtitle: Text(stolist.warehouse?.name ?? ''),
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    'TIPE BIAYA',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF2C2C2C)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    stolist.costType ?? '',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: primaryBlue),
                                  ),
                                ),
                              ]),
                          Container(
                            color: const Color(0xFF313131),
                            child: Row(
                              children: const [
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Nama Bahan',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Keluar',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.pink),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Awal',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Sisa',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          stolist.items!.isNotEmpty
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: stolist.items!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) => Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            stolist.items?[i].name ?? '',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                              '-${stolist.items?[i].quantity}',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.red)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                              stolist.items?[i].initalStock
                                                      .toString() ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.blueAccent)),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                              stolist.items?[i].itemStock
                                                      .toString() ??
                                                  '',
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  color: Colors.green)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container()
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: <Widget>[
                          //     TextButton(
                          //       child: const Text(stolist.items.),
                          //       onPressed: () {/* ... */},
                          //     ),
                          //     const SizedBox(width: 8),
                          //     TextButton(
                          //       child: const Text('LISTEN'),
                          //       onPressed: () {/* ... */},
                          //     ),
                          //     const SizedBox(width: 8),
                          //   ],
                          // ),
                        ],
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
