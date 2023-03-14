import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/purchase-orders/filter-po.dart';
import 'package:siangmalam/models/purchase-orders/po-item.dart';
import 'package:siangmalam/models/purchase-orders/po-product.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/po/purchase-item.service.dart';

class PoItemUploadControllerV2 extends GetxController {
  // var log = Logger();
  late int? branchId = AppStatic.userData.branchId;
  int? subBranchId;

  // DATA
  var listPoitem = ListPoItem().obs;

  var imageProof = ImagePurchaseRequestDto(fileName: '', filePath: '').obs;

  var listImagesRequest = <ImagePurchaseRequestDto>[].obs;

  var imageUrlProof = ''.obs;
  var imagePathProof = ''.obs;
  var fileNameProof = ''.obs;

  var isSubmit = false.obs;

  @override
  void onInit() {
    super.onInit();
    listPoitem.value = Get.arguments ?? ListPoProduct();
    // log.d(listPoitem.toJson());
  }

  saveImageProof(String imagePath, String imageName) async {
    imageProof.value =
        ImagePurchaseRequestDto(fileName: imageName, filePath: imagePath);
    listImagesRequest.add(imageProof.value);
  }

  submitProofImage() {
    // log.d(listImagesRequest.toJson());
    if (listImagesRequest.isNotEmpty) {
      uploadImageProf();
    } else {
      Get.snackbar("Oops", "Belum ada upload apapun",
          backgroundColor: mtRed600, colorText: textColor);
    }
  }

  validatorsProof() {
    if (listPoitem.value.status == 'DONE') return true;
    return false;
  }

  Future<void> uploadImageProf() async {
    isSubmit.value = true;
    bool result = await PurchaseItemService.uploadProof(
        listImagesRequest, listPoitem.value.orderNo!);
    isSubmit.value = false;
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  // }
}
