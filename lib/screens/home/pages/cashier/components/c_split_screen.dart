import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/cashier/spilt_form_controller.dart';
import 'package:siangmalam/commons/size_config.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/form_values.dart';
import 'package:siangmalam/models/cashier/splitbill.dart';
import 'package:siangmalam/models/order/create-order-response.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';

class SplitFormScreen extends GetView<SplitFormController> {
  const SplitFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context),
        body: bodySplitForm(context));
  }

  Container bodySplitForm(BuildContext context) {
    var node = FocusScope.of(context);
    return Container(
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: primaryLightGrey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Obx(() => controller.cartItem.isNotEmpty
                    ? initBodyCard(context)
                    : Center(
                        child: Text(
                          "Item Kosong!",
                          style: TextStyle(fontSize: 9.sp),
                        ),
                      )),
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(1.sp),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.all(1.sp),
                          child: listForm(context),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(
                        color: primaryLightGrey,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Obx(
                            () => listGridSplit(),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: primaryDarkGreen,
                        child: Padding(
                          padding: EdgeInsets.all(1.sp),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 8,
                                  child: Obx(
                                    () => Container(
                                      child: Text(
                                        "Note : ${controller.getNote()}",
                                        textScaleFactor: 1.5,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 4.sp),
                                      ),
                                    ),
                                  )),
                              Expanded(
                                flex: 2,
                                child: Obx(
                                  () => ElevatedButton(
                                    child: Text('Pisahkan',
                                        style: TextStyle(fontSize: 6.sp)),
                                    onPressed: controller.getAllowedSpill()
                                        ? () async {
                                            await controller.onSubmitSplit();
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: const Size.fromHeight(100),
                                      primary: primaryGoldText,
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Form listForm(BuildContext context) {
    var node = FocusScope.of(context);
    return Form(
      key: controller.formKey,
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: TextFormField(
              style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.normal),
              enabled: true,
              controller: controller.textFieldNameController.value,
              keyboardType: TextInputType.text,
              onSaved: (String? val) {},
              decoration: InputDecoration(
                fillColor: primaryLightGrey,
                filled: true,
                enabledBorder: const OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey, width: 0.0),
                ),
                focusedBorder: InputBorder.none,
                prefixIconConstraints: BoxConstraints(minWidth: 5.w),
                suffixIconConstraints: BoxConstraints(minWidth: 5.w),
                // border: outlineInputBorder,
                hintText: "masukan nama",
                errorText: null,
                labelStyle: const TextStyle(color: primaryGrey),
                contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 1.w),
                  child: Icon(
                    Icons.person,
                    color: primaryGoldText,
                    size: 9.sp,
                  ),
                ),
              ),
              onEditingComplete: () => node.nextFocus(),
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          Expanded(
            flex: 4,
            child: TextFormField(
              style: TextStyle(fontSize: 8.sp, fontWeight: FontWeight.normal),
              enabled: true,
              controller: controller.textFieldNoteController.value,
              keyboardType: TextInputType.text,
              onSaved: (String? val) {},
              decoration: InputDecoration(
                fillColor: primaryLightGrey,
                filled: true,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                prefixIconConstraints: BoxConstraints(minWidth: 5.w),
                suffixIconConstraints: BoxConstraints(minWidth: 5.w),
                // border: outlineInputBorder,
                hintText: "keterangan jika perlu",
                // labelText: label,
                labelStyle: TextStyle(color: primaryGrey),
                contentPadding: EdgeInsets.symmetric(horizontal: 2.w),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(right: 1.w),
                  child: Icon(
                    Icons.note_alt,
                    color: primaryGoldText,
                    size: 9.sp,
                  ),
                ),
              ),
              onEditingComplete: () => node.nextFocus(),
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              child: Text('Tambah +', style: TextStyle(fontSize: 6.sp)),
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                controller.addBill();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(100),
                primary: primaryDarkGreen,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  GridView listGridSplit() {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          // childAspectRatio: 2,
          crossAxisCount: 2,
          // crossAxisSpacing: 20,
          // mainAxisSpacing: 20,
        ),
        itemCount: controller.bills.length,
        itemBuilder: (BuildContext ctx, index) {
          return Padding(
            padding: EdgeInsets.all(2.sp),
            child: buildPersonWithDropZone(index),
          );
        });
  }

  Widget buildPersonWithDropZone(int index) {
    // List<ItemsSplit>? list = controller.bills.elementAt(index).items;
    return Container(
      color: Colors.transparent,
      child: DragTarget<Cart>(
        onWillAccept: (data) => true,
        onAccept: (data) {
          // print(data.toJson());
          // removeAll(data);
          controller.itemDroppedOnCustomerCart(data, index);
        },
        builder: (context, candidateItems, rejectedItems) => Card(
          elevation: 8,
          color: candidateItems.isNotEmpty ? primaryLightGrey : Colors.white,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(2.sp),
                  child: ListTile(
                    leading: Icon(Icons.list, size: 14.sp),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, size: 14.sp),
                      iconSize: 14.sp,
                      onPressed: () {
                        controller.deleteBills(index);
                      },
                    ),
                    title: Text(
                      controller.bills.elementAt(index).name!,
                      style: TextStyle(
                          fontSize: 10.sp, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      "Keterangan : ${controller.bills.elementAt(index).note!}",
                      style: TextStyle(fontSize: 6.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: Padding(
                  padding: EdgeInsets.all(1.sp),
                  child: Container(
                      color: Colors.transparent,
                      child: Obx(
                        () => controller.bills.elementAt(index).items.isNotEmpty
                            ? initListItemCart(index)
                            : Center(
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.archive,
                                    size: 14.sp,
                                  ),
                                  Text(
                                    "Tarik item, lalu taruh item disini",
                                    style: TextStyle(fontSize: 9.sp),
                                  )
                                ],
                              )),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView initListItemCart(int index) {
    return ListView.builder(
      itemCount: controller.bills.elementAt(index).items.length,
      itemBuilder: (context, i) {
        return Container(
          color: primaryLightGrey,
          margin: EdgeInsets.symmetric(vertical: 0.2.h, horizontal: 1.w),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.h),
              child: Row(
                children: [
                  Expanded(
                      flex: 8,
                      child: Text(
                        controller.bills
                                .elementAt(index)
                                .items
                                .elementAt(i)
                                .name ??
                            "",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryDarkGreen,
                            fontSize: 10.sp),
                      )),
                  Expanded(
                      flex: 2,
                      child: Text(
                        "x${controller.bills.elementAt(index).items.elementAt(i).amount}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: primaryDarkGreen,
                            fontSize: 10.sp),
                      )),
                ],
              )),
        );
      },
    );
  }

  ListView initBodyCard(BuildContext context) {
    return ListView.builder(
      itemCount: controller.cartItem.length,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.symmetric(vertical: 0.5.h),
        child: Obx(
          () => initCartCard(
              context, index, controller.cartItem.elementAt(index)),
        ),
      ),
    );
  }

  Widget initCartCard(BuildContext ctx, int idx, Cart? cart) {
    final GlobalKey _draggableKey = GlobalKey();

    return cart!.amount != 0
        ? Draggable<Cart>(
            data: cart,
            dragAnchorStrategy: pointerDragAnchorStrategy,
            feedback: DraggingListItem(
              dragKey: _draggableKey,
              photoProvider: NetworkImage(cart.pic!),
              nameItem: cart.name!,
              amountItem: cart.amount!,
            ),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(3.sp),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: const BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x53343434),
                              offset: Offset(4, 4),
                              spreadRadius: 1,
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            controller.cartItem[idx].pic.toString(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      flex: 7,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.cartItem[idx].name ?? '',
                            style: TextStyle(
                                color: primaryDarkGreen,
                                fontWeight: FontWeight.w600,
                                fontSize: 6.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
                          // const SizedBox(height: 10),
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.convertPrice(controller.cartItem[idx].unitPrice)}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 6.sp,
                                    color: const Color(0xAF000000),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Obx(
                                  () => Text(
                                    'x' +
                                        controller.cartItem[idx].amount
                                            .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 7.sp,
                                      color: primaryDarkGreen,
                                    ),
                                  ),
                                ),
                                // const SizedBox(width: 20),
                              ],
                            ),
                          ),
                          Obx(
                            () => Text(
                              "${controller.convertPrice(controller.cartItem[idx].totalPrice)}",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 8.sp,
                                color: primaryGoldText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
        : Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x53343434),
                            offset: Offset(4, 4),
                            spreadRadius: 1,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.network(
                          controller.cartItem[idx].pic.toString(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.cartItem[idx].name ?? '',
                          style: TextStyle(
                              color: primaryDarkGreen,
                              fontWeight: FontWeight.w600,
                              fontSize: 6.sp),
                          overflow: TextOverflow.ellipsis,
                        ),
                        // const SizedBox(height: 10),
                        Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${controller.convertPrice(controller.cartItem[idx].unitPrice)}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 6.sp,
                                  color: const Color(0xAF000000),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Obx(
                                () => Text(
                                  'x' +
                                      controller.cartItem[idx].amount
                                          .toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 7.sp,
                                    color: primaryDarkGreen,
                                  ),
                                ),
                              ),
                              // const SizedBox(width: 20),
                            ],
                          ),
                        ),
                        Obx(
                          () => Text(
                            "${controller.convertPrice(controller.cartItem[idx].totalPrice)}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 8.sp,
                              color: primaryGoldText,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        padding: EdgeInsets.only(left: 5.w),
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      title: Column(
        children: [
          Text(
            "Pisah Pesanan",
            style: TextStyle(color: Colors.black, fontSize: 10.sp),
          ),
          Text(
            "Kasir",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}

class CustomerCart extends StatelessWidget {
  const CustomerCart({
    required this.bills,
    this.highlighted = false,
    this.hasItems = false,
  });

  final Bills bills;
  final bool highlighted;
  final bool hasItems;

  @override
  Widget build(BuildContext context) {
    final textColor = highlighted ? Colors.white : Colors.black;

    return Transform.scale(
      scale: highlighted ? 1.075 : 1.0,
      child: Material(
        elevation: highlighted ? 8.0 : 4.0,
        borderRadius: BorderRadius.circular(22.0),
        color: highlighted ? const Color(0xFFF64209) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 24.0,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ClipOval(
              //   child: SizedBox(
              //     width: 46,
              //     height: 46,
              //     child: Image(
              //       image: bills.name?? ,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 8.0),
              Text(
                bills.name ?? "",
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: textColor,
                      fontWeight:
                          hasItems ? FontWeight.normal : FontWeight.bold,
                    ),
              ),
              Visibility(
                visible: hasItems,
                maintainState: true,
                maintainAnimation: true,
                maintainSize: true,
                child: Column(
                  children: [
                    const SizedBox(height: 4.0),
                    Text(
                      bills.items.toString(),
                      style: Theme.of(context).textTheme.caption!.copyWith(
                            color: textColor,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '${bills.items.length} item${bills.items.length != 1 ? 's' : ''}',
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: textColor,
                            fontSize: 12.0,
                          ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    required this.dragKey,
    required this.photoProvider,
    required this.nameItem,
    required this.amountItem,
  });

  final GlobalKey dragKey;
  final ImageProvider photoProvider;
  final String nameItem;
  final int amountItem;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
        translation: const Offset(-0.5, -0.5),
        child: Card(
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outline,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: SizedBox(
                height: 10.h,
                width: 50.w,
                child: Container(
                    color: Colors.transparent,
                    child: Padding(
                      padding: EdgeInsets.all(1.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: ClipRRect(
                              key: dragKey,
                              borderRadius: BorderRadius.circular(12.0),
                              child: SizedBox(
                                // height: 7.h,
                                // width: 12.w,
                                child: Opacity(
                                  opacity: 0.85,
                                  child: Image(
                                    image: photoProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(1.sp),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "$nameItem ",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9.sp),
                                    ),
                                    Text(
                                      "x1",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 9.sp),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    )))));
  }
}
