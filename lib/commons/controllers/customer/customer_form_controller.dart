import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/controllers/customer/customer_controller.dart';
import 'package:siangmalam/commons/functions/orientations.dart';
import 'package:siangmalam/models/customer/create_customer_dto.dart';
import 'package:siangmalam/models/customer/update_customer_dto.dart';
import 'package:siangmalam/services/customer/customer_service.dart';

class CustomerFormController extends GetxController {
  CustomerController customercontroller = Get.find();

  final formKey = GlobalKey<FormState>();
  var idCust = 0.obs;
  late TextEditingController nameController = TextEditingController();
  late TextEditingController address1Controller = TextEditingController();
  late TextEditingController address2Controller = TextEditingController();
  late TextEditingController address3Controller = TextEditingController();
  late TextEditingController phoneController = TextEditingController();

  // var log = Logger();
  @override
  void onInit() {
    Orientations.forcePortrait();
    super.onInit();
    idCust.value = customercontroller.listcustomer.value.id ?? 0;
    nameController.text = customercontroller.listcustomer.value.name ?? '';
    address1Controller.text =
        customercontroller.listcustomer.value.address1 ?? '';
    address2Controller.text =
        customercontroller.listcustomer.value.address2 ?? '';
    address3Controller.text =
        customercontroller.listcustomer.value.address3 ?? '';
    phoneController.text = customercontroller.listcustomer.value.phone ?? '';
  }

  submitProfile() {
    if (formKey.currentState!.validate()) {
      if (idCust.value > 0) {
        UpdateCustomerDto dto = UpdateCustomerDto();
        dto.id = idCust.value;
        dto.name = nameController.text.toString();
        dto.address1 = address1Controller.text.toString();
        dto.address2 = address2Controller.text.toString();
        dto.address3 = address3Controller.text.toString();
        dto.phone = phoneController.text.toString();
        CustomerService.updateCustomer(dto);
      } else {
        CreateCustomerDto dto = CreateCustomerDto();
        dto.name = nameController.text.toString();
        dto.address1 = address1Controller.text.toString();
        dto.address2 = address2Controller.text.toString();
        dto.address3 = address3Controller.text.toString();
        dto.phone = phoneController.text.toString();
        CustomerService.createCustomer(dto);
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
  }
}
