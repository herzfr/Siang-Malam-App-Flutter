import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siangmalam/commons/controllers/po-purchasing/item/po-item-upload.controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:sizer/sizer.dart';

class PurchaseItemUploadScreen extends GetView<PoItemUploadControllerV2> {
  static String routeName = " /v2/po-pruduct/upload";
  PurchaseItemUploadScreen({Key? key}) : super(key: key);

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(context),
      body: body(context),
    );
  }

  Container body(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Column(children: [
          const Text(
            'Upload Bukti Barang/Bahan/Produk',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 3.h),
            child: SizedBox(
              height: 100.w,
              width: 90.w,
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // shape: BoxShape.circle,
                      border: Border.all(color: primaryYellow, width: 2),
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 2,
                            color: Colors.grey,
                            spreadRadius: 1,
                            offset: Offset(0, 4))
                      ],
                    ),
                    child: Obx(
                      () {
                        if (controller.listPoitem.value.proofPic != null) {
                          return Image(
                            image: CachedNetworkImageProvider(
                                controller.listPoitem.value.proofPic!),
                          );
                        } else {
                          if (controller.imageProof.value.fileName.isNotEmpty) {
                            return Image.file(
                                File(controller.imageProof.value.filePath));
                          } else {
                            return const Image(
                              image: AssetImage(noPicImageSquare),
                            );
                          }
                        }
                      },
                    ),
                  ),
                  Positioned(
                    right: -16,
                    bottom: -10,
                    child: SizedBox(
                      height: 56,
                      width: 56,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                            side: const BorderSide(color: primaryYellow),
                          ),
                          primary: Colors.white,
                          backgroundColor: const Color(0xFFF5F6F9),
                        ),
                        onPressed: () {
                          imageSelectorCameraProof();
                        },
                        child: Material(
                            elevation: 5,
                            child: SvgPicture.asset(
                                "assets/icons/Camera Icon.svg")),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () {
              if (controller.imageProof.value.fileName.isNotEmpty ||
                  controller.listPoitem.value.proofPic != null) {
                return getStatusUpload(true);
              } else {
                return getStatusUpload(false);
              }
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: Obx(() => generateSubmitButton()),
          )
        ]));
  }

  TextButton generateSubmitButton() {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryLightGrey),
        elevation: MaterialStateProperty.all(8),
        minimumSize: MaterialStateProperty.all(Size.fromHeight(6.h)),
      ),
      child: controller.isSubmit.isFalse
          ? Text(
              'Sesuaikan',
              style: TextStyle(color: primaryDarkGreen, fontSize: 9.sp),
            )
          : SizedBox(
              height: 1.9.h,
              width: 3.3.w,
              child: const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
                backgroundColor: Colors.blue,
                strokeWidth: 3,
              ),
            ),
      onPressed: () {
        print('asdasd');
        controller.submitProofImage();
      },
    );
  }

  imageSelectorCameraProof() async {
    // Get.back();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
      maxHeight: maxImageHeight,
      maxWidth: maxImageWidth,
    );
    imageUploadProof(image);
  }

  imageUploadProof(XFile? image) {
    if (image != null) {
      var imagePath = image.path;
      var fileName = (imagePath.split('/').last);
      Get.defaultDialog(
          title: "Ubah Bukti",
          middleText: "Anda akan mengunggah foto bukti barang, lanjutkan?",
          backgroundColor: whiteBg,
          titleStyle: const TextStyle(color: mtGrey700),
          middleTextStyle: const TextStyle(color: mtGrey700),
          textConfirm: confirmYes,
          textCancel: confirmNo,
          cancelTextColor: mtGrey700,
          confirmTextColor: mtGrey700,
          buttonColor: primaryYellow,
          onConfirm: () {
            Get.back();
            controller.saveImageProof(imagePath, fileName);
          });
    }
  }

  getStatusUpload(bool status) {
    if (status) {
      return Padding(
        padding: const EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), // <= No more error here :)
            color: const Color(0xFF07BC7A).withOpacity(0.8),
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          margin: const EdgeInsets.only(bottom: 5.0),
          child: const Text(
            "Uploaded",
            style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
          ), // Text
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(left: 20, top: 5, right: 20, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), // <= No more error here :)
          color: const Color(0xFFB81788).withOpacity(0.8),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        margin: const EdgeInsets.only(bottom: 5.0),
        child: const Text(
          "Belum Upload",
          style: TextStyle(fontSize: 14, color: Color(0xFFFFFFFF)),
        ), // Text
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      backgroundColor: primaryDarkGreen,
      elevation: 2,
      leading: IconButton(
        padding: EdgeInsets.only(left: 5.w),
        onPressed: () {
          Get.back();
        },
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
      ),
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            // flex: 7,
            child: Text(
              "Upload bukti pembelian pesanan",
              style: TextStyle(color: Colors.white, fontSize: 9.sp),
            ),
          ),
        ],
      ),
    );
  }
}
