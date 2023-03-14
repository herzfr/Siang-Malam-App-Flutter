import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siangmalam/commons/controllers/po/po_item_details_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:sizer/sizer.dart';

class PoItemPic extends GetView<PoItemDetailsController> {
  PoItemPic({Key? key}) : super(key: key);

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Upload Bukti Struk Belanja/Invoice/DLL',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 3.h),
          child: SizedBox(
            height: 50.w,
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
                      if (controller.poitemlist.value.receiptPic != null) {
                        return Image(
                          image: CachedNetworkImageProvider(
                              controller.poitemlist.value.receiptPic!),
                        );
                      } else {
                        return const Image(
                          image: AssetImage(avatarImage),
                        );
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
                        imageSelectorCameraReceipt();
                        // Get.bottomSheet(
                        //     SizedBox(
                        //       height: 20.h,
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Column(
                        //           children: [
                        //             ListTile(
                        //               leading: const Icon(Icons.photo_library),
                        //               title: const Text('Image Galery'),
                        //               onTap: () {
                        //                 imageSelectorGalleryReceipt();
                        //               },
                        //             ),
                        //             ListTile(
                        //               leading: const Icon(Icons.photo_camera),
                        //               title: const Text('Camera'),
                        //               onTap: () {
                        //                 imageSelectorCameraReceipt();
                        //               },
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     elevation: 20.0,
                        //     enableDrag: true,
                        //     backgroundColor: Colors.white,
                        //     shape: const RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.only(
                        //       topLeft: Radius.circular(15.0),
                        //       topRight: Radius.circular(15.0),
                        //     )));
                      },
                      child: Material(
                          elevation: 5,
                          child:
                              SvgPicture.asset("assets/icons/Camera Icon.svg")),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Obx(
          () {
            if (controller.imageReceipt.value.fileName.isNotEmpty ||
                controller.poitemlist.value.receiptPic != null) {
              return getStatusUpload(true);
            } else {
              return getStatusUpload(false);
            }
          },
        ),
        const Text(
          'Upload Bukti Barang Yang Telah Dibeli',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 3.h),
          child: SizedBox(
            height: 50.w,
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
                      if (controller.poitemlist.value.proofPic != null) {
                        return Image(
                          image: CachedNetworkImageProvider(
                              controller.poitemlist.value.proofPic!),
                        );
                      } else {
                        return const Image(
                          image: AssetImage(avatarImage),
                        );
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
                        // Get.bottomSheet(
                        //     SizedBox(
                        //       height: 20.h,
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Column(
                        //           children: [
                        //             ListTile(
                        //               leading: const Icon(Icons.photo_library),
                        //               title: const Text('Image Galery'),
                        //               onTap: () {
                        //                 imageSelectorGalleryProof();
                        //               },
                        //             ),
                        //             ListTile(
                        //               leading: const Icon(Icons.photo_camera),
                        //               title: const Text('Camera'),
                        //               onTap: () {
                        //                 imageSelectorCameraProof();
                        //               },
                        //             ),
                        //           ],
                        //         ),
                        //       ),
                        //     ),
                        //     elevation: 20.0,
                        //     enableDrag: true,
                        //     backgroundColor: Colors.white,
                        //     shape: const RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.only(
                        //       topLeft: Radius.circular(15.0),
                        //       topRight: Radius.circular(15.0),
                        //     )));
                      },
                      child: Material(
                          elevation: 5,
                          child:
                              SvgPicture.asset("assets/icons/Camera Icon.svg")),
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
                controller.poitemlist.value.proofPic != null) {
              return getStatusUpload(true);
            } else {
              return getStatusUpload(false);
            }
          },
        ),
      ],
    );
  }

  // imageSelectorGalleryReceipt() async {
  //   Get.back();
  //   final XFile? image = await picker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: imageQuality,
  //     maxHeight: maxImageHeight,
  //     maxWidth: maxImageWidth,
  //   );
  //   imageUploadReceipt(image);
  // }

  // imageSelectorGalleryProof() async {
  //   Get.back();
  //   final XFile? image = await picker.pickImage(
  //     source: ImageSource.gallery,
  //     imageQuality: imageQuality,
  //     maxHeight: maxImageHeight,
  //     maxWidth: maxImageWidth,
  //   );
  //   imageUploadProof(image);
  // }

  imageSelectorCameraReceipt() async {
    // Get.back();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
      maxHeight: maxImageHeight,
      maxWidth: maxImageWidth,
    );
    imageUploadReceipt(image);
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

  imageUploadReceipt(XFile? image) {
    if (image != null) {
      var imagePath = image.path;
      var fileName = (imagePath.split('/').last);
      Get.defaultDialog(
          title: "Ubah Bukti",
          middleText:
              "Anda akan mengunggah foto bukti struk/invoice/dll, lanjutkan?",
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
            controller.saveImageReceipt(imagePath, fileName);
          });
    }
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
