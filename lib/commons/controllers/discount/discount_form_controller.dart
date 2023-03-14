import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/controllers/discount/discount_controller.dart';
import 'package:siangmalam/commons/functions/orientations.dart';
import 'package:siangmalam/constans/option_value.dart';
import 'package:siangmalam/models/branch/general_branch.dart';
import 'package:siangmalam/models/discount/discount.dart';
import 'package:siangmalam/models/discount/request/request_discount_dto.dart';
import 'package:siangmalam/models/subbranch/general_sub_branch.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/branch/branch_service.dart';
import 'package:siangmalam/services/discount/discount_service.dart';

class DiscountFormController extends GetxController {
  // var log = Logger();
  var whoIs = AppStatic.userData.role.obs;
  DiscountController discController = Get.find();

  final dropBranch = GlobalKey<FormFieldState>();
  final formKey = GlobalKey<FormState>();
  var nameController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var typeController = TextEditingController().obs;
  var valueController = TextEditingController().obs;
  var branchIdController = TextEditingController().obs;
  var subBranchIdController = TextEditingController().obs;

  var discSelected = ListDiscount().obs;

  // DATA
  var branch = GeneralBranch().obs;
  var subbranch = GeneralSubBranch().obs;

  // DROPDOWN
  var typeDrop = <DropdownMenuItem<String>>[].obs;

  // DROPDOWN CONTROL
  var branchDropDown = <DropdownMenuItem<int>>[].obs;
  var subbranchDropDown = <DropdownMenuItem<int>>[].obs;

  // BOOL
  var isSubAvailable = false.obs;
  var isNewDiscount = false.obs;

  @override
  void onInit() {
    Orientations.forcePortrait();
    typeDrop.value = typeDisc;
    whoIsThis();
    super.onInit();
  }

  whoIsThis() {
    // ignore: unrelated_type_equality_checks
    if (whoIs == 'ADMIN') {
      init();
    } else {
      initNotAdmin();
    }
  }

  initNotAdmin() {
    branch = discController.branch;
    discSelected = discController.discSelected;

    // log.d(discSelected.value.toJson());

    if (discSelected.value.branchId == null) {
      isNewDiscount.value = true;
      branchIdController = TextEditingController(text: 0.toString()).obs;

      nameController.value.text = '';
      descriptionController.value.text = '';
      typeController.value.text = 'PERCENT';
      valueController.value.text = '0.0';
      branchIdController.value.text = AppStatic.userData.branchId.toString();
      subBranchIdController.value.text = '0';

      branchDropDown.add(DropdownMenuItem<int>(
          child: Text(AppStatic.userData.branch ?? ''),
          value: AppStatic.userData.branchId));
      getDataSubBranch(int.parse(branchIdController.value.text));
    } else {
      isNewDiscount.value = false;

      if (discSelected.value.subBranchId == null) {
        isSubAvailable.value = false;
        subBranchIdController = TextEditingController(text: 0.toString()).obs;
      }

      // branchDropDown = discController.branchDropDown;
      // subbranchDropDown = discController.subbranchDropDown;
      branchDropDown.add(DropdownMenuItem<int>(
          child: Text(AppStatic.userData.branch ?? ''),
          value: AppStatic.userData.branchId));
      getDataSubBranch(discSelected.value.branchId!);

      // INIT DATA FROM SELF
      nameController.value.text = discSelected.value.name ?? '';
      descriptionController.value.text = discSelected.value.description ?? '';
      typeController.value.text = discSelected.value.type ?? '';
      valueController.value.text = discSelected.value.value.toString();
      branchIdController.value.text = discSelected.value.branchId.toString();
    }
  }

  init() {
    // INIT DATA FROM ANOTHER CONTROLLER

    branch = discController.branch;
    discSelected = discController.discSelected;

    // log.d(discSelected.value.branchId);
    // log.d(discSelected.value.subBranchId);
    if (discSelected.value.branchId == null) {
      isNewDiscount.value = true;
      branchIdController = TextEditingController(text: 0.toString()).obs;

      nameController.value.text = '';
      descriptionController.value.text = '';
      typeController.value.text = 'PERCENT';
      valueController.value.text = '0.0';
      branchIdController.value.text = AppStatic.userData.branchId.toString();
      subBranchIdController.value.text = '0';

      getDataBranch();
      getDataSubBranch(int.parse(branchIdController.value.text));
      subbranchDropDown.add(const DropdownMenuItem<int>(
          child: Text("Hanya Cabang Induk"), value: 0));
    } else {
      isNewDiscount.value = false;

      if (discSelected.value.subBranchId == null) {
        isSubAvailable.value = false;
        subBranchIdController = TextEditingController(text: 0.toString()).obs;
      }

      // branchDropDown = discController.branchDropDown;
      // subbranchDropDown = discController.subbranchDropDown;
      getDataBranch();
      getDataSubBranch(discSelected.value.branchId!);

      // INIT DATA FROM SELF
      nameController.value.text = discSelected.value.name ?? '';
      descriptionController.value.text = discSelected.value.description ?? '';
      typeController.value.text = discSelected.value.type ?? '';
      valueController.value.text = discSelected.value.value.toString();
      branchIdController.value.text = discSelected.value.branchId.toString();
    }
  }

  initDropDown() {}

  getDataSubBranch(int value) {
    fetchDataSubBranchByBranchId(value);
  }

  getDataBranch() {
    fetchDataBranch();
  }

  fetchDataBranch() async {
    var data = await BranchService.getAllDataBranch();
    branch.value = data;
    _initDropdownBranch();
  }

  fetchDataSubBranchByBranchId(int id) async {
    var data = await BranchService.getSubBranchDataByBranchId(id);
    subbranch.value = data;
    _initDropdownSubBranch();
  }

  _initDropdownBranch() {
    // branchDropDown.add(const DropdownMenuItem<int>(
    //     child: Text("Semua Induk Cabang"), value: 0));
    for (var item in branch.value.listbranch!) {
      // log.d(item.name.toString());
      branchDropDown.add(DropdownMenuItem<int>(
          child: Text(item.name.toString()), value: item.id));
    }
    branchDropDown.refresh();
  }

  _initDropdownSubBranch() {
    // subBranchIdController.value.text =
    //     discSelected.value.subBranchId.toString();
    // log.d(discSelected.value.subBranchId);
    // log.d(subBranchIdController.value.text);
    // log.d(subBranchIdController.value.text);
    if (discSelected.value.subBranchId == null) {
      isSubAvailable.value = false;
      subBranchIdController = TextEditingController(text: null.toString()).obs;
    }
    // subbranchDropDown.clear();
    var dropdown = <DropdownMenuItem<int>>[].obs;
    // // subBranchIdController.value = TextEditingController();
    // log.d(subBranchIdController.value.text);
    dropdown.add(const DropdownMenuItem<int>(
        child: Text("Hanya Cabang Induk"), value: null));
    for (var item in subbranch.value.listsubbranch!) {
      dropdown.add(DropdownMenuItem<int>(
          child: Text(item.name.toString()), value: item.id));
    }
    subbranchDropDown.clear();
    subbranchDropDown = dropdown;
    // // subbranchDropDown.refresh();
    update();
  }

  @override
  void onClose() {
    Orientations.defaultOrientation();
    super.onClose();
    nameController.value.dispose();
    descriptionController.value.dispose();
    typeController.value.dispose();
    valueController.value.dispose();
    branchIdController.value.dispose();
    subBranchIdController.value.dispose();
  }

  void submitCreate() {
    if (formKey.currentState!.validate()) {
      DiscountCreateDto discountDto = DiscountCreateDto();

      discountDto.name = nameController.value.text.toString();
      discountDto.description = descriptionController.value.text.toString();
      discountDto.type = typeController.value.text.toString();
      discountDto.value = double.parse(valueController.value.text);
      discountDto.branchId = int.parse(branchIdController.value.text);
      discountDto.subBranchId = int.parse(subBranchIdController.value.text) == 0
          ? null
          : int.parse(subBranchIdController.value.text);

      // log.d(discountDto.toJson());
      DiscountService.createDiscount(discountDto);
    }
  }

  void submitUpdate() {
    if (formKey.currentState!.validate()) {
      DiscountUpdateDto discountDto = DiscountUpdateDto();
      discountDto.id = discSelected.value.id;
      discountDto.name = nameController.value.text.toString();
      discountDto.description = descriptionController.value.text.toString();
      discountDto.type = typeController.value.text.toString();
      discountDto.value = double.parse(valueController.value.text);
      discountDto.branchId = int.parse(branchIdController.value.text);
      // log.d(subBranchIdController.value.text);
      discountDto.subBranchId = discSelected.value.subBranchId;
      // log.d(discountDto.toJson());
      DiscountService.updateDiscount(discountDto);
    }
  }
}
