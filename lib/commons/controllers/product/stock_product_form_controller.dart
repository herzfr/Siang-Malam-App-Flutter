import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/controllers/product/stock_product_controller.dart';
import 'package:siangmalam/commons/functions/orientations.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/product/stock_product.dart';
import 'package:siangmalam/models/product/stock_transfer.dart';
import 'package:siangmalam/models/warehouse/warehouse.dart';
import 'package:siangmalam/services/product/product_service.dart';
import 'package:siangmalam/services/warehouse/warehouse_service.dart';

class StockProductFormController extends GetxController {
  StockProductController controller = Get.find();

  final formKey = GlobalKey<FormState>();
  final dropdownState = GlobalKey<FormFieldState>();
  var listProduct = ListProducts().obs;
  // ignore: unnecessary_this
  get productName => this.listProduct.value.product?.name;
  get fromWarehouse => this.listProduct.value.warehouse?.name;

  var idFrom = 0.obs;
  late TextEditingController fromQty = TextEditingController();
  late TextEditingController toQty = TextEditingController();

  var menuItems = <DropdownMenuItem<ListWarehouse>>[].obs;
  var selectedItem = ListWarehouse().obs;

  // DATA MODEL
  late Warehouse _warehouse;
  late ListProducts product;

  // var log = Logger();
  get value => null;

  @override
  Future<void> onInit() async {
    Orientations.defaultOrientation();
    // log.d(controller.listProduct.value.warehouseId);
    listProduct.value = controller.listProduct.value;
    idFrom.value = controller.listProduct.value.warehouseId!;
    fromQty.text = (controller.listProduct.value.quantity ?? 0).toString();
    toQty.text = (0).toString();

    initDropDown();
    _fetchWarehouse();
    toQty.addListener(() {
      change();
    });
    super.onInit();
  }

  @override
  void onClose() {
    Orientations.defaultOrientation();
    // log.d('===');
    super.onClose();
  }

  onChange(ListWarehouse listWarehouse) {
    // log.d(listWarehouse.toJson());
    dropdownState.currentState?.didChange(listWarehouse);
    // log.d(dropdownState);
  }

  // ============================================
  // INIT DROPDOWN
  // ============================================
  initDropDown() {
    // ignore: invalid_use_of_protected_member
    menuItems.value
        .add(const DropdownMenuItem(child: Text("Pilih Tujuan"), value: null));
  }

  // ============================================
  // GET DATA
  // ============================================
  Future<void> _fetchWarehouse() async {
    _warehouse = await WarehouseService.getWarehouse();
    for (var item in _warehouse.listwarehouse!) {
      // ignore: invalid_use_of_protected_member
      if (idFrom.value != item.id) {
        menuItems.value
            .add(DropdownMenuItem(child: Text(item.name!), value: item));
      }
    }
  }

  // ============================================
  // ADD AND REMOVE CHANGE QUANTITY
  // ============================================
  add() {
    // log.d("works");
    // log.d(controller.listProduct.value.toJson());
    var from = main(fromQty.text);
    var to = main(toQty.text);
    from--;
    to++;
    fromQty.text = from.toString();
    toQty.text = to.toString();
  }

  remove() {
    // log.d("works");
    // log.d(controller.listProduct.value.toJson());
    var from = main(fromQty.text);
    var to = main(toQty.text);
    if (to > 0) {
      from++;
      to--;
    }
    fromQty.text = from.toString();
    toQty.text = to.toString();
  }

  int main(String arguments) {
    try {
      var str = arguments == '' ? (0).toString() : arguments;
      int? a = int.parse(str);
      return a.abs();
    } on FormatException {
      return 0;
    }
  }

  change() {
    int to = main(toQty.text);
    int from = controller.listProduct.value.quantity!;
    if (to == from) {
      // log.d("ke sama dengan dari");
      fromQty.text = (0).toString();
    } else if (to > from) {
      // log.d("ke lebih besar dengan dari");
      toQty.text = from.toString();
    } else {
      fromQty.text = (controller.listProduct.value.quantity! - to).toString();
    }
  }

  void submitTransfer() {
    // log.d(selectedItem.value.toJson());
    if (selectedItem.value.id != null) {
      if (formKey.currentState!.validate()) {
        StockTransferDto transferDto = StockTransferDto();
        List<Products> stkProdList = [];
        Products stfDtoProd = Products();

        stfDtoProd.productId = controller.listProduct.value.productId;
        stfDtoProd.quantity = main(toQty.text);
        stkProdList.add(stfDtoProd);

        transferDto.products = stkProdList;
        transferDto.frmWarehouseId = idFrom.value;
        transferDto.destWarehouseId = selectedItem.value.id;

        // log.d(transferDto.toJson());
        ProductService.transferProduct(transferDto);
      }
    } else {
      Get.snackbar("Perhatian!", "Anda belum memilih tujuan gudang.",
          backgroundColor: mtRed600, colorText: textColor);
    }
  }

  void setState(Null Function() param0) {}
}
