import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/commons/controllers/po-product/po_product_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/purchase-order-product/po_prod_approval_dto.dart';
import 'package:siangmalam/models/purchase-order-product/po_prod_update_dto.dart';
import 'package:siangmalam/models/purchase-order-product/po_products.dart';
// import 'package:siangmalam/models/purchase-order/po-item-proof.dart';
// import 'package:siangmalam/models/purchase-order/po-item-update.dart';
// import 'package:siangmalam/models/purchase-order/po-item.dart';
import 'package:siangmalam/models/user/image_profile_request.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/po/po_prod_service.dart';
import 'package:siangmalam/services/po/po_service.dart';
import 'package:siangmalam/widgets/snack_bar.dart';

class PoProductDetailsController extends GetxController {
  final PoProductController _poItemController = Get.find();
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

  var poproductlist = PoProductList().obs;
  var productpo = <ProductsList>[].obs;

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

  get prodpovalueqty => productpo.value;

  @override
  void onInit() {
    poproductlist.value = _poItemController.poprodlist.value;
    controllersNote.value.text = poproductlist.value.note ?? '';
    fetchData();
    productpo.value.addAll(poproductlist.value.products!);
    // log.d(whoIs);
    super.onInit();
  }

  plus(int index) {
    controllersQty.value[index].text =
        (main(controllersQty.value[index].text) + 1).toString();
    poproductlist.value.products?[index].quantity =
        main(controllersQty.value[index].text);
    // log.d(poproductlist.value.toJson());
  }

  minus(int index) {
    controllersQty.value[index].text =
        (main(controllersQty.value[index].text) - 1).toString();
    poproductlist.value.products?[index].quantity =
        main(controllersQty.value[index].text);
    // log.d(poproductlist.value.toJson());
  }

  qtyChange(int index, String value) {
    controllersQty.value[index].text = value;
    poproductlist.value.products?[index].quantity =
        main(controllersQty.value[index].text);
    // log.d(poproductlist.value.toJson());
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
    poproductlist.value.products?[i].quantity =
        main(controllersQty.value[i].text);
    // log.d(poproductlist.value.products?[i].quantity);
  }

  priceOnSubmit(int index, String value) {
    controllersCost.value[index].text =
        (main(convertStringToNumber(value))).toString();
    poproductlist.value.products?[index].cost =
        main(controllersCost.value[index].text);
  }

  priceChange(int i) {
    // log.d("work");
    poproductlist.value.products?[i].cost =
        (main(convertStringToNumber(controllersCost.value[i].text)));
    // log.d(poproductlist.value.products?[i].cost);
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
    if (poproductlist.value.proofPic == null &&
        poproductlist.value.receiptPic == null) {
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
        .uploadProof(listImagesRequest, poproductlist.value.orderNo!);
    if (result) {
      Snackbar.show("Success", "Upload Success", mtGrey500, mtGrey50);
      isUpdate.value = true;
      fetchData();
    }
  }

  fetchData() async {
    poproductlist.value =
        await PoProductService.getProdwithNoOrder(poproductlist.value.orderNo!);
    poproductlist.refresh();
  }

  updateData() async {
    PoProductUpdateDto updateDto = PoProductUpdateDto();
    List<PoProductUpdate> productList = [];

    for (var item in poproductlist.value.products!) {
      PoProductUpdate prod = PoProductUpdate();
      prod.id = item.id;
      prod.productId = item.productId;
      prod.quantity = item.quantity;
      prod.cost = item.cost;
      productList.add(prod);
    }

    updateDto.orderNo = poproductlist.value.orderNo;
    updateDto.note = poproductlist.value.note;
    updateDto.suplierId = poproductlist.value.suplierId;
    updateDto.products = productList;

    // log.d(updateDto.toJson());
    PoProductService.updatePoProduct(updateDto)
        .then((value) => {if (value) fetchData(), isUpdate.value = true});
  }

  validatorsProof() {
    if (poproductlist.value.status == 'DONE') return true;
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
    PoProductApprovalDto proofDto = PoProductApprovalDto();
    List<ProductsList> productList = [];

    for (var item in poproductlist.value.products!) {
      ProductsList it = ProductsList();
      it.id = item.id;
      it.productId = item.productId;
      it.quantity = item.quantity;
      it.cost = item.cost;
      it.status = item.status;
      productList.add(it);
    }

    proofDto.orderNo = poproductlist.value.orderNo;
    proofDto.note = poproductlist.value.note;
    proofDto.expenseStatus = poproductlist.value.expenses?.status;
    proofDto.status = poproductlist.value.status;
    proofDto.products = productList;

    // log.d(proofDto.toJson());
    PoProductService.proofPoProduct(proofDto)
        .then((value) => {if (value) fetchData(), isUpdate.value = true});
  }

  cancelData() {
    PoProductService.cancelPoProduct(poproductlist.value.orderNo!)
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
