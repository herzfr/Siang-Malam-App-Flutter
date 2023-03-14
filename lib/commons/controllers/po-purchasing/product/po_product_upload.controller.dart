import 'package:get/get.dart';
// import 'package:logger/logger.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/models/purchase-orders/filter-po.dart';
import 'package:siangmalam/models/purchase-orders/po-product.dart';
import 'package:siangmalam/services/app_static.dart';
import 'package:siangmalam/services/po/purchase-product.service.dart';

class PoUploadController extends GetxController {
  // var log = Logger();
  late int? branchId = AppStatic.userData.branchId;
  int? subBranchId;

  // DATA
  var listPoproduct = ListPoProduct().obs;

  var imageProof = ImagePurchaseRequestDto(fileName: '', filePath: '').obs;

  var listImagesRequest = <ImagePurchaseRequestDto>[].obs;

  var imageUrlProof = ''.obs;
  var imagePathProof = ''.obs;
  var fileNameProof = ''.obs;

  var isSubmit = false.obs;

  @override
  void onInit() {
    super.onInit();
    listPoproduct.value = Get.arguments ?? ListPoProduct();
    // log.d(listPoproduct.toJson());
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
    if (listPoproduct.value.status == 'DONE') return true;
    return false;
  }

  Future<void> uploadImageProf() async {
    isSubmit.value = true;
    bool result = await PurchaseProductService.uploadProof(
        listImagesRequest, listPoproduct.value.orderNo!);
    isSubmit.value = false;
  }

  // @override
  // void onClose() {
  //   // TODO: implement onClose
  //   super.onClose();
  // }
}
