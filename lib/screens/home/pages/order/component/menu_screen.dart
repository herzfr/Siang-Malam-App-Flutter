import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:siangmalam/commons/controllers/order/order_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/enums.dart';
import 'package:siangmalam/models/order/menu.dart';
import 'package:siangmalam/models/order/package.dart';
import 'package:siangmalam/widgets/custom_input.dart';
import 'package:sizer/sizer.dart';

class MenuScreen extends GetView<OrderController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1.w),
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: searchField(context),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Obx(() => controller.character == TypeMenu.product
                ? categoryField(context)
                : Container()),
          ),
          Padding(
            padding: const EdgeInsets.all(1),
            child: typeField(context),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Obx(() {
              return DropdownButtonFormField<String>(
                // key: controller.dropStatus,
                items: controller.dDCategoryPrice,
                value: controller.priceWho.value,
                decoration:
                    CustomFormWidget.customInputDecoration('', 'Tipe Harga'),
                onChanged: (value) {
                  controller.priceWho.value = value!;
                  // controller.generatePrice();
                },
              );
            }),
          ),
          Expanded(
            child: Padding(
                padding: const EdgeInsets.all(0),
                child: Obx(
                  () => controller.character == TypeMenu.product
                      ? pageMenuProduct(context)
                      : pageMenuPackage(context),
                )),
          ),
        ],
      ),
    );
  }

  // CONTAINER PACKAGE
  Container pageMenuPackage(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Obx(
            () => controller.listMenuPackage.isNotEmpty
                ? initMenuPackage(controller)
                : Center(
                    child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Paket tidak ada,\n Coba untuk mengganti kata kunci pencaharian atau Kategori.',
                      textAlign: TextAlign.center,
                    ),
                  )),
          ),
          if (controller.loading.isTrue) ...[
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
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

  // CONTAINER PRODUCT
  Container pageMenuProduct(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(
        children: [
          Obx(
            () => controller.listMenuProduct.isNotEmpty
                ? initMenuProduct(controller)
                : Center(
                    child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Menu tidak ada,\n Coba untuk mengganti kata kunci pencaharian atau Kategori.',
                      textAlign: TextAlign.center,
                    ),
                  )),
          ),
          if (controller.loading.isTrue) ...[
            Positioned(
              left: 0,
              bottom: 0,
              child: Container(
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

  // MENU
  // =====================================
  ListView initMenuPackage(OrderController controller) {
    return ListView.separated(
        controller: controller.sc.value,
        // physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index < controller.listMenuPackage.length) {
            return Obx(
              () => Container(
                child: controller.checkPrice(index) != null
                    ? cardPakcage(context, index, controller.checkPrice(index))
                    : cardPakcage(context, index, "Rp -"),
              ),
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: const Center(
                child: Text("Tidak ada lagi paket"),
              ),
            );
          }
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 1,
          );
        },
        itemCount: controller.listMenuPackage.value.length +
            (controller.allLoaded.value ? 1 : 0));
  }

  // MENU
  // =====================================
  GridView initMenuProduct(OrderController controller) {
    return GridView.builder(
        controller: controller.sc.value,
        // shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.60,
          // crossAxisSpacing: 20,
        ),
        // const SliverGridDelegateWithMaxCrossAxisExtent(
        //     maxCrossAxisExtent: 200,
        //     childAspectRatio: 3 / 3,
        //     crossAxisSpacing: 20,
        //     mainAxisSpacing: 20),
        itemCount: controller.listMenuProduct.value.length +
            (controller.allLoaded.value ? 1 : 0),
        itemBuilder: (BuildContext ctx, index) {
          if (index < controller.listMenuProduct.length) {
            return Obx(
              () => Container(
                alignment: Alignment.center,
                // color: primaryYellow,
                margin: const EdgeInsets.all(5),
                // child: Text(controller.listTable[index].name.toString()),
                child: controller.checkPrice(index) != null
                    ? cardProduct(ctx, index, controller.checkPrice(index))
                    : cardProduct(ctx, index, "Rp -"),
              ),
            );
          } else {
            return Container(
              width: MediaQuery.of(ctx).size.width,
              height: 50,
              child: const Center(
                child: Text("Tidak ada lagi menu"),
              ),
            );
          }
        });
  }

  setupAlertDialoadContainerList(List<ProductsPackage>? ls) {
    return Container(
      alignment: Alignment.center,
      height: 200.0, // Change as per your requirement
      width: 200.0, // Change as per your requirement
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: ls!.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Row(
                children: [
                  Text(
                    ls[index].name.toString(),
                    style: TextStyle(
                        color: ls[index].quantity == 0
                            ? Colors.red
                            : Colors.black),
                  ),
                  const Spacer(),
                  Text(
                    ls[index].quantity.toString(),
                    style: TextStyle(
                        color: ls[index].quantity == 0
                            ? Colors.red
                            : Colors.black),
                  )
                ],
              )
            ],
          );
        },
      ),
    );
  }

  // CARD PACKAGE
  // =====================================
  Card cardPakcage(BuildContext context, int index, String price) {
    return Card(
        elevation: 2,
        shadowColor: Colors.green,
        // color: Color(0xFFE9E9E9),
        margin: const EdgeInsets.all(1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          onLongPress: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Center(child: Text('Produk Paket?')),
                  content: setupAlertDialoadContainerList(
                      controller.listMenuPackage[index].products),
                  actions: <Widget>[
                    Center(
                      child: ElevatedButton(
                          child: const Text('Ok'),
                          style: ElevatedButton.styleFrom(primary: primaryBlue),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                  ],
                );
              }),
          onTap: () {
            if (controller.checkStock(index) && price != 'Rp -') {
              controller.insertToCartForPackage(index);
            } else if (controller.checkStock(index) && price == 'Rp -') {
              Get.defaultDialog(
                title: "Oops!",
                middleText: "Paket tidak tersedia untuk tipe harga " +
                    controller.priceWho.value,
                backgroundColor: whiteBg,
                titleStyle: const TextStyle(color: mtGrey700),
                middleTextStyle: const TextStyle(color: mtGrey700),
                // textConfirm: "Ok",
                textCancel: "Ok",
                cancelTextColor: mtGrey700,
                confirmTextColor: mtGrey700,
                buttonColor: primaryYellow,
              );
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Center(child: Text('Stok yang habis?')),
                      content: setupAlertDialoadContainerList(
                          controller.listMenuPackage[index].products),
                      actions: <Widget>[
                        Center(
                          child: ElevatedButton(
                              child: const Text('Ok'),
                              style: ElevatedButton.styleFrom(
                                  primary: primaryBlue),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                        ),
                      ],
                    );
                  });
            }
          },
          child: Container(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: controller.listMenuPackage[index].pic != null
                          ? Image.network(
                              controller.listMenuPackage[index].pic.toString())
                          : Image.asset('assets/images/no_pic.png'),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.listMenuPackage[index].name.toString(),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color(0xF7232323)),
                          ),
                          // Text(
                          //   controller
                          //       .listMenuPackage[index].description
                          //       .toString(),
                          //   textAlign: TextAlign.center,
                          //   maxLines: 2,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: const TextStyle(
                          //       fontWeight: FontWeight.w400,
                          //       color: Color(0xF7232323)),
                          // ),
                          Text(
                            controller.listPackageproduct(index),
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xF7232323),
                                fontSize: 12),
                          ),
                          Text(
                            price,
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xF7232323),
                                fontSize: 14),
                          ),
                          Obx(
                            () => Text(
                              controller.checkStock(index)
                                  ? "Tersedia"
                                  : "Beberapa stok kosong",
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: controller.checkStock(index)
                                      ? const Color(0xF7047A9A)
                                      : const Color(0xF79A0461),
                                  fontSize: 14),
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
        ));
  }

  // CARD PRODUCT
  // =====================================
  InkWell cardProduct(BuildContext context, int idx, String price) {
    return InkWell(
      onTap: () {
        if (price != 'Rp -') {
          controller.insertToCartForProduct(idx);
        } else {
          Get.defaultDialog(
            title: "Oops!",
            middleText: "Menu tidak tersedia untuk tipe harga " +
                controller.priceWho.value,
            backgroundColor: whiteBg,
            titleStyle: const TextStyle(color: mtGrey700),
            middleTextStyle: const TextStyle(color: mtGrey700),
            // textConfirm: "Ok",
            textCancel: "Ok",
            cancelTextColor: mtGrey700,
            confirmTextColor: mtGrey700,
            buttonColor: primaryYellow,
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        height: 200,
        width: 200,
        decoration: BoxDecoration(
          color: primaryYellow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: controller.listMenuProduct[idx].pic != null
                  ? Image.network(
                      controller.listMenuProduct[idx].pic.toString())
                  : Image.asset('assets/images/no_pic.png'),
            ),
            Expanded(
              child: Text(
                controller.listMenuProduct[idx].name.toString(),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontWeight: FontWeight.w400, color: Color(0xF7232323)),
              ),
            ),
            Text(
              controller.listMenuProduct[idx].quantity.toString() +
                  ' ' +
                  controller.listMenuProduct[idx].unit.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: controller.listMenuProduct[idx].quantity != 0
                      ? const Color(0xF709B67A)
                      : const Color(0xF7FF279A)),
            ),
            Text(
              price,
              textAlign: TextAlign.left,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Color(0xFF232323)),
            ),
          ],
        ),
      ),
    );
  }

  // TIPE
  // =====================================

  // TIPE
  // =====================================
  Container typeField(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Obx(
        () => Row(
          children: [
            Expanded(
              flex: 1,
              child: ListTile(
                title: const Text('Per Produk'),
                leading: Radio<TypeMenu>(
                  value: TypeMenu.product,
                  groupValue: controller.character.value,
                  onChanged: (TypeMenu? value) {
                    controller.character.value = value!;
                    controller.refreshDataMenu();
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: ListTile(
                title: const Text('Paketan'),
                leading: Radio<TypeMenu>(
                  value: TypeMenu.package,
                  groupValue: controller.character.value,
                  onChanged: (TypeMenu? value) {
                    controller.character.value = value!;
                    controller.refreshDataMenu();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CATEGORY
  // =====================================
  Container categoryField(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10 / 2),
      height: 30,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.categoryMenuList.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  // print('work');
                  controller.selectedCategory.value = index;
                  controller.refreshDataMenu();
                },
                child: Obx(
                  () => Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: index == controller.selectedCategory.value
                            ? primaryYellow
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                        controller.categoryMenuList[index].name.toString()),
                  ),
                ),
              )),
    );
  }

  // SEARCH
  // =====================================
  Container searchField(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          // color: primaryGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        textInputAction: TextInputAction.search,
        controller: controller.textFieldController.value,
        // onChanged: (value) => controller.changeTotalPerPage(10, value),
        onSubmitted: (value) {
          controller.search.value = value;
          controller.refreshDataMenu();
        },
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
}
