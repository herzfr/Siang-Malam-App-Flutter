import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:siangmalam/commons/controllers/po/po_item_create_controller.dart';
import 'package:siangmalam/models/product/items.dart';
import 'package:siangmalam/models/purchase-order/po-item-list.dart';
import 'package:sizer/sizer.dart';

class FilterItemsScreen extends GetView<PoItemCreateController> {
  const FilterItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: searchField(context, controller)),
          Expanded(flex: 8, child: listItemData(context, controller)),
        ],
      ),
    );
  }
}

Container listItemData(
    BuildContext context, PoItemCreateController controller) {
  return Container(
    child: Obx(() {
      return PagedListView<int, PoItemListData>.separated(
          pagingController: controller.pagingControllerDataItem.value,
          padding: const EdgeInsets.all(1),
          separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
          shrinkWrap: true,
          builderDelegate: PagedChildBuilderDelegate<PoItemListData>(
            itemBuilder: (context, stockItems, index) => Card(
              elevation: 2,
              shadowColor: Colors.green,
              // color: Color(0xFFE9E9E9),
              margin: const EdgeInsets.all(1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: GestureDetector(
                  child: ListTile(
                leading: const Icon(
                  Icons.arrow_right,
                  color: Colors.amberAccent,
                  size: 50,
                ),
                title: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      stockItems.name ?? '',
                      textScaleFactor: 0.8,
                    ),
                    const Spacer(),
                    Text(
                      'Per / ${stockItems.unit}',
                      textScaleFactor: 0.8,
                    ),
                  ],
                ),
                onTap: () {
                  controller.insertItemToList(index);
                  // Get.toNamed(RouteName.stockItemTransferScreen)?.then(
                  //     (value) => controller.logData(value ?? false));
                  // showBottomSheet(context, index, stockproduct);
                },
              )),
            ),
          ));

      // );
    }),
  );
}

Container searchField(BuildContext context, PoItemCreateController controller) {
  return Container(
    // width: MediaQuery.of(context).size.width * .66,
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
