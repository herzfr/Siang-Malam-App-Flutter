import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/controllers/po/po_item_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/purchase-order/po-item-proof.dart';
import 'package:siangmalam/models/purchase-order/po-item-update.dart';
import 'package:siangmalam/models/purchase-order/po-item.dart';
import 'package:siangmalam/models/user/image_profile_request.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/po/po_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class PoItemDetailsController extends GetxController {
  final PoItemController _poItemController = Get.find();
  // var log = Logger();
  var whoIs = AppStatic.userData.role.obs;

  var statusSt = [
    const DropdownMenuItem<String>(child: Text('Dibuat'), value: 'CREATED'),
    // const DropdownMenuItem<String>(child: Text('Tertunda'), value: 'PENDING'),
    const DropdownMenuItem<String>(child: Text('Selesai'), value: 'DONE'),
    const DropdownMenuItem<String>(child: Text('Diubah'), value: 'UPDATED'),
    const DropdownMenuItem<String>(child: Text('Batal'), value: 'CANCEL'),
  ].obs;

  var statusStatement = [
    const DropdownMenuItem<String>(child: Text('Dibuat'), value: 'CREATED'),
    // const DropdownMenuItem<String>(child: Text('Tertunda'), value: 'PENDING'),
    const DropdownMenuItem<String>(child: Text('Selesai'), value: 'DONE'),
    const DropdownMenuItem<String>(child: Text('Diubah'), value: 'UPDATED'),
    const DropdownMenuItem<String>(child: Text('Batal'), value: 'CANCEL'),
  ].obs;

  var statusPayment = [
    const DropdownMenuItem<String>(child: Text('Batal'), value: 'CANCEL'),
    const DropdownMenuItem<String>(child: Text('Hutang'), value: 'PENDING'),
    const DropdownMenuItem<String>(child: Text('Lunas'), value: 'PAID'),
    const DropdownMenuItem<String>(child: Text('Tidak Bayar'), value: 'UNPAID'),
  ].obs;

  var poitemlist = PoItemList().obs;
  var itempo = <ItemsPo>[].obs;

  // IMAGE
  var listImagesRequest = <ImageProfileRequestDto>[].obs;

  var imageProof = ImageProfileRequestDto(filePath: '', fileName: '').obs;
  var imageReceipt = ImageProfileRequestDto(filePath: '', fileName: '').obs;

  var imageUrlReceipt = ''.obs;
  var imagePathReceipt = ''.obs;
  var fileNameReceipt = ''.obs;

  var imageUrlProof = ''.obs;
  var imagePathProof = ''.obs;
  var fileNameProof = ''.obs;

  var isUpdate = false.obs;

  // final List<TextEditingController> controllersdynamic = [];
  final controllersCost = <TextEditingController>[].obs;
  final controllersQty = <TextEditingController>[].obs;
  final controllersNote = TextEditingController().obs;

  get itemspovalueqty => itempo.value;

  @override
  void onInit() {
    poitemlist.value = _poItemController.poitemlist.value;
    controllersNote.value.text = poitemlist.value.note ?? '';
    fetchData();
    itempo.value.addAll(poitemlist.value.items!);
    // log.d(whoIs);
    super.onInit();
  }

  plus(int index) {
    controllersQty.value[index].text =
        (main(controllersQty.value[index].text) + 1).toString();
    poitemlist.value.items?[index].quantity =
        main(controllersQty.value[index].text);
    // log.d(poitemlist.value.toJson());
  }

  minus(int index) {
    controllersQty.value[index].text =
        (main(controllersQty.value[index].text) - 1).toString();
    poitemlist.value.items?[index].quantity =
        main(controllersQty.value[index].text);
    // log.d(poitemlist.value.toJson());
  }

  qtyChange(int index, String value) {
    controllersQty.value[index].text = value;
    poitemlist.value.items?[index].quantity =
        main(controllersQty.value[index].text);
    // log.d(poitemlist.value.toJson());
  }

  // priceChange(int index, String value) {
  //   // log.d(
  //   //     "priceChange => ${controllersCost.value[index].text} dengan value ${convertStringToNumber(value)}");
  //   controllersCost.value[index].text =
  //       (main(convertStringToNumber(value))).toString();
  //   poitemlist.value.items?[index].cost =
  //       main(controllersCost.value[index].text);
  //   // log.d("works => ${itempo[index].cost}");
  //   log.d(poitemlist.toJson());
  // }

  quantityIntChange(int i) {
    // log.d("work");
    poitemlist.value.items?[i].quantity = main(controllersQty.value[i].text);
    // log.d(poitemlist.value.items?[i].quantity);
  }

  priceOnSubmit(int index, String value) {
    controllersCost.value[index].text =
        (main(convertStringToNumber(value))).toString();
    poitemlist.value.items?[index].cost =
        main(controllersCost.value[index].text);
  }

  priceChange(int i) {
    // log.d("work");
    poitemlist.value.items?[i].cost =
        (main(convertStringToNumber(controllersCost.value[i].text)));
    // log.d(poitemlist.value.items?[i].cost);
  }

  convertStringToNumber(String value) {
    var str = value.replaceAll(RegExp(r'[^0-9]'), '');
    return str;
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

  saveImageProof(String imagePath, String imageName) async {
    imageProof.value =
        ImageProfileRequestDto(fileName: imageName, filePath: imagePath);
  }

  saveImageReceipt(String imagePath, String imageName) async {
    imageReceipt.value =
        ImageProfileRequestDto(fileName: imageName, filePath: imagePath);
  }

  disableButtonUpload() {
    if (poitemlist.value.proofPic == null &&
        poitemlist.value.receiptPic == null) {
      return true;
    }
    return false;
  }

  validatorsUpload() {
    if (imageReceipt.value.fileName.isNotEmpty &&
        imageProof.value.fileName.isNotEmpty) return true;
    return false;
  }

  logImages() {
    // log.d("image worked");
    // log.d(imageReceipt.value.fileName);
    // log.d(imageProof.value.fileName);
    saveImages(imageReceipt.value.filePath, imageReceipt.value.fileName);
    saveImages(imageProof.value.filePath, imageProof.value.fileName);
    // log.d(listImagesRequest.value.length);
  }

  saveImages(String imagePath, String imageName) async {
    listImagesRequest
        .add(ImageProfileRequestDto(fileName: imageName, filePath: imagePath));
  }

  prePostImages() {
    if (validatorsUpload()) {
      // Snackbar.show("Success", "Upload Success", mtGrey500, mtGrey50);
      saveImages(imageProof.value.filePath, imageProof.value.fileName);
      saveImages(imageReceipt.value.filePath, imageReceipt.value.fileName);
      postImages();
    } else {
      Snackbar.show(
          "Opps!", "Mohon upload bukti terlebih dahulu", mtRed600, mtGrey50);
    }
  }

  postImages() async {
    var result = await PoService()
        .uploadProof(listImagesRequest, poitemlist.value.orderNo!);
    if (result) {
      Snackbar.show("Success", "Upload Success", mtGrey500, mtGrey50);
      isUpdate.value = true;
      fetchData();
    }
  }

  fetchData() async {
    poitemlist.value =
        await PoService.getItemWithNoOrder(poitemlist.value.orderNo!);
    poitemlist.refresh();
  }

  updateData() async {
    PoUpdateDto updateDto = PoUpdateDto();
    List<ItemsUpdateDto> itemsList = [];

    for (var item in poitemlist.value.items!) {
      ItemsUpdateDto it = ItemsUpdateDto();
      it.id = item.id;
      it.itemId = item.itemId;
      it.quantity = item.quantity;
      it.cost = item.cost;
      itemsList.add(it);
    }

    updateDto.orderNo = poitemlist.value.orderNo;
    updateDto.note = poitemlist.value.note;
    updateDto.suplierId = poitemlist.value.suplierId;
    updateDto.items = itemsList;

    // log.d(updateDto.toJson());
    PoService.updatePoItems(updateDto)
        .then((value) => {if (value) fetchData(), isUpdate.value = true});
  }

  validatorsProof() {
    if (poitemlist.value.status == 'DONE') return true;
    return false;
  }

  preProofData() {
    if (validatorsProof()) {
      proofData();
    } else {
      Snackbar.show(
          "Opps!",
          "Mohon ubah status menjadi selesai apabila menyetujui",
          mtGrey50,
          mtGrey50);
    }
  }

  proofData() async {
    PoItemProofDto proofDto = PoItemProofDto();
    List<ItemsProofDto> itemsList = [];

    for (var item in poitemlist.value.items!) {
      ItemsProofDto it = ItemsProofDto();
      it.id = item.id;
      it.itemId = item.itemId;
      it.quantity = item.quantity;
      it.cost = item.cost;
      it.status = item.status;
      itemsList.add(it);
    }

    proofDto.orderNo = poitemlist.value.orderNo;
    proofDto.note = poitemlist.value.note;
    proofDto.expenseStatus = poitemlist.value.expenses?.status;
    proofDto.status = poitemlist.value.status;
    proofDto.items = itemsList;

    // log.d(proofDto.toJson());
    PoService.proofPoItems(proofDto)
        .then((value) => {if (value) fetchData(), isUpdate.value = true});
  }

  cancelData() {
    PoService.cancelPoItems(poitemlist.value.orderNo!)
        .then((value) => {if (value) fetchData(), isUpdate.value = true});
  }

  priceComplete(int i) {
    // log.d(i);
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  // }
}
