import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/controllers/order/order_controller.dart';
import 'package:siangmalam/commons/functions/orientations.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/order/table.dart';
import 'package:siangmalam/models/order/upsert-table.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/order/order_service.dart';

class TableFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  OrderController orderController = Get.find();

  late int? branchId;
  int? subBranchId;
  // int? id;
  ListTable? lTable;
  String? role = AppStatic.userData.role;
  // TEXT FORM CONTROLLER MEJA
  final textFieldUpsertTableNameController = TextEditingController().obs;
  final textFieldUpsertTableDescController = TextEditingController().obs;

  // var log = Logger();

  @override
  void onInit() {
    Orientations.forcePortrait();
    super.onInit();
    branchId = orderController.branchId;
    subBranchId = orderController.subBranchId;
    // log.d(lTable?.toJson());
    // log.d(textFieldUpsertTableNameController.value.text);
    // log.d(textFieldUpsertTableDescController.value.text);
    // log.d(orderController.selectedTableActive.toJson());
    onClear();
    lTable = orderController.selectedTableActive.value;
    initForm();
  }

  void initForm() {
    if (lTable!.id != null) {
      textFieldUpsertTableNameController.value.text = lTable!.name.toString();
      textFieldUpsertTableDescController.value.text =
          lTable!.description.toString();
    }
  }

  initDeleteButton() {
    if (role == "MANAGER" && lTable!.id != null ||
        role == "ADMIN" && lTable!.id != null) {
      return true;
    }
    return false;
  }

  isOccupied() {
    if (lTable!.isOccupied!) {}
  }

  deleteTable() {
    OrderService.deleteTable(lTable!.id.toString());
  }

  void submit() {
    if (formKey.currentState!.validate()) {
      // log.d('work ${lTable!.id}');
      if (lTable!.id != null) {
        UpdateTable ut = UpdateTable();
        ut.id = lTable!.id;
        ut.branchId = branchId;
        ut.subBranchId = subBranchId;
        ut.name = textFieldUpsertTableNameController.value.text;
        ut.description = textFieldUpsertTableDescController.value.text;
        ut.isOccupied = lTable!.isOccupied;
        OrderService.updateTable(ut);
      } else {
        CreateTable ct = CreateTable();
        ct.branchId = branchId;
        ct.subBranchId = subBranchId;
        ct.name = textFieldUpsertTableNameController.value.text;
        ct.description = textFieldUpsertTableDescController.value.text;
        OrderService.createTable(ct);
      }
    } else {
      Get.snackbar("Perhatian!", "Isian masih ada yang kosong.",
          backgroundColor: mtRed600, colorText: textColor);
    }
  }

  onClear() {
    textFieldUpsertTableNameController.value.clear();
    textFieldUpsertTableDescController.value.clear();
    textFieldUpsertTableNameController.refresh();
    textFieldUpsertTableDescController.refresh();
    lTable = ListTable();
  }

  @override
  void onClose() {
    Orientations.defaultOrientation();
    super.onClose();
    textFieldUpsertTableNameController.value.dispose();
    textFieldUpsertTableDescController.value.dispose();
    lTable = ListTable();
  }
}
