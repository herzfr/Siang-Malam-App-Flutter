import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/controllers/suplier/suplier_controller.dart';
import 'package:siangmalam/commons/functions/orientations.dart';
import 'package:siangmalam/models/suplier/supliercreatedto.dart';
import 'package:siangmalam/models/suplier/suplierdto.dart';
import 'package:siangmalam/services/suplier/suplier_service.dart';

class SuplierFormController extends GetxController {
  SuplierController supliercontroller = Get.find();

  final formKey = GlobalKey<FormState>();
  var idSuplier = 0.obs;
  late TextEditingController nameController = TextEditingController();
  late TextEditingController address1Controller = TextEditingController();
  late TextEditingController address2Controller = TextEditingController();
  late TextEditingController address3Controller = TextEditingController();
  late TextEditingController phoneController = TextEditingController();
  late TextEditingController emailController = TextEditingController();

  // var log = Logger();

  @override
  void onInit() {
    Orientations.forcePortrait();
    super.onInit();
    idSuplier.value = supliercontroller.listsuplier.value.id ?? 0;
    nameController.text = supliercontroller.listsuplier.value.name ?? '';
    address1Controller.text =
        supliercontroller.listsuplier.value.address1 ?? '';
    address2Controller.text =
        supliercontroller.listsuplier.value.address2 ?? '';
    address3Controller.text =
        supliercontroller.listsuplier.value.address3 ?? '';
    phoneController.text = supliercontroller.listsuplier.value.phone ?? '';
    emailController.text = supliercontroller.listsuplier.value.email ?? '';
  }

  submitProfile() {
    if (formKey.currentState!.validate()) {
      if (idSuplier.value > 0) {
        SuplierDto dto = SuplierDto();
        dto.id = idSuplier.value;
        dto.name = nameController.text.toString();
        dto.address1 = address1Controller.text.toString();
        dto.address2 = address2Controller.text.toString();
        dto.address3 = address3Controller.text.toString();
        dto.phone = phoneController.text.toString();
        dto.email = emailController.text.toString();
        SuplierService.updateSuplier(dto);
      } else {
        SuplierCreateDto dto = SuplierCreateDto();
        dto.name = nameController.text.toString();
        dto.address1 = address1Controller.text.toString();
        dto.address2 = address2Controller.text.toString();
        dto.address3 = address3Controller.text.toString();
        dto.phone = phoneController.text.toString();
        dto.email = emailController.text.toString();
        SuplierService.createSuplier(dto);
      }
    }
  }

  @override
  void onClose() {
    Orientations.defaultOrientation();
    super.onClose();
    nameController.dispose();
    address1Controller.dispose();
    address2Controller.dispose();
    address3Controller.dispose();
    phoneController.dispose();
    emailController.dispose();
  }
}
