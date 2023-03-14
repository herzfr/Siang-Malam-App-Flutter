import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siangmalam/commons/controllers/profile/account_controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProfilePic extends GetView<AccountController> {
  ProfilePic({Key? key}) : super(key: key);

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38.w,
      width: 38.w,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
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
                if (controller.imageUrl.isNotEmpty) {
                  return CircleAvatar(
                    backgroundColor: whiteBg,
                    backgroundImage:
                        CachedNetworkImageProvider(controller.imageUrl.value),
                  );
                } else {
                  return const CircleAvatar(
                    backgroundColor: whiteBg,
                    backgroundImage: AssetImage(avatarImage),
                  );
                }
              },
            ),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 6.h,
              width: 6.h,
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
                  Get.bottomSheet(
                      SizedBox(
                        height: 18.h,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('Image Galery'),
                                onTap: () {
                                  imageSelectorGallery();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_camera),
                                title: const Text('Camera'),
                                onTap: () {
                                  imageSelectorCamera();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 20.0,
                      enableDrag: true,
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      )));
                },
                child: Material(
                    elevation: 5,
                    child: SvgPicture.asset("assets/icons/Camera Icon.svg")),
              ),
            ),
          )
        ],
      ),
    );
  }

  imageSelectorGallery() async {
    Get.back();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
      maxHeight: maxImageHeight,
      maxWidth: maxImageWidth,
    );
    imageChange(image);
  }

  imageSelectorCamera() async {
    Get.back();
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
      maxHeight: maxImageHeight,
      maxWidth: maxImageWidth,
    );
    imageChange(image);
  }

  imageChange(XFile? image) {
    if (image != null) {
      var imagePath = image.path;
      var fileName = (imagePath.split('/').last);
      Get.defaultDialog(
          title: "Ubah Foto",
          middleText: "Anda akan mengubah foto profil, lanjutkan?",
          backgroundColor: whiteBg,
          titleStyle: const TextStyle(color: mtGrey700),
          middleTextStyle: const TextStyle(color: mtGrey700),
          textConfirm: confirmYes,
          textCancel: confirmYes,
          cancelTextColor: mtGrey700,
          confirmTextColor: mtGrey700,
          buttonColor: primaryYellow,
          onConfirm: () {
            Get.back();
            controller.saveImage(imagePath, fileName);
          });
    }
  }
}
