import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:siangmalam/commons/controllers/po-purchasing/product/po_product_credit.controller.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/enums.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:sizer/sizer.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PurchaseProductCreditScreen extends GetView<PoProductCreditController> {
  static String routeName = " /v2/po-pruduct/credit";
  PurchaseProductCreditScreen({Key? key}) : super(key: key);

  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    controller.panelHeightOpen = MediaQuery.of(context).size.height * .99;
    ;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(context),
      body: Obx(() => bodyMode(context)),
    );
  }

  bodyMode(BuildContext context) {
    if (controller.listPoproduct.value.paidStatus == 'DONE') {
      return body(context);
    } else {
      return SlidingUpPanel(
        maxHeight: controller.panelHeightOpen,
        minHeight: controller.panelHeightClosed,
        controller: controller.pcs,
        parallaxEnabled: true,
        parallaxOffset: .10,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        panel: Center(
          child: filter(context),
        ),
        body: body(context),
      );
    }
  }

  Container filter(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.arrow_drop_up,
                color: primaryGrey,
              ),
              SizedBox(
                height: 0.5.h,
              ),
              const SizedBox(
                child: Text('Form Pembayaran Angsuran'),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: TextFormField(
                      style: TextStyle(fontSize: 9.sp, color: mtGrey800),
                      controller: controller.textFieldAmount.value,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        CurrencyTextInputFormatter(
                          locale: 'id',
                          decimalDigits: 0,
                          symbol: 'Rp ',
                        ),
                      ],
                      onSaved: (String? val) {},
                      onFieldSubmitted: (value) {
                        controller.textFieldAmount.value.text = value;
                      },
                      // onChanged: (value) {
                      //   controller.onChangeValueAmount(value);
                      // },
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Total",
                        filled: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.textFieldAmount.value.text =
                                  0.toString();
                            },
                            icon: const Icon(Icons.clear,
                                color: Color(0xFFDFC012))),
                        // icon: const Icon(Icons.clear),
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.monetization_on,
                              color: Color(0xFFDFC012)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 2.6.h),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                      child: Obx(() =>
                          controller.detailPurchasing.value.purchaseProduct !=
                                  null
                              ? Text(
                                  'Sisa ${controller.convertPrice(controller.detailPurchasing.value.purchaseProduct!.remaining ?? 0)}',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(fontSize: 10.sp),
                                )
                              : Container()))
                ],
              ),
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('Tunai'),
                        leading: Radio<PaymentMethod>(
                          fillColor:
                              MaterialStateProperty.all(primaryDarkGreen),
                          value: PaymentMethod.cash,
                          groupValue: controller.paymentMethodt.value,
                          onChanged: (PaymentMethod? value) {
                            controller.paymentMethodt.value = value!;
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('Lainnya'),
                        leading: Radio<PaymentMethod>(
                          fillColor:
                              MaterialStateProperty.all(primaryDarkGreen),
                          value: PaymentMethod.custom,
                          groupValue: controller.paymentMethodt.value,
                          onChanged: (PaymentMethod? value) {
                            controller.paymentMethodt.value = value!;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() => controller.paymentMethodt.value == PaymentMethod.custom
                  ? categoryFieldPayment(context)
                  : Container()),
              Obx(
                () => controller.paymentMethodt.value == PaymentMethod.custom
                    ? TextFormField(
                        style: TextStyle(fontSize: 8.sp, color: mtGrey800),
                        controller: controller.textFieldtransactionNo.value,
                        keyboardType: TextInputType.text,
                        onSaved: (String? val) {},
                        decoration: InputDecoration(
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          hintText: "No Transaksi",
                          filled: true,
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.textFieldtransactionNo.value.text =
                                    '';
                              },
                              icon: const Icon(Icons.clear,
                                  color: Color(0xFFDFC012))),
                          // icon: const Icon(Icons.clear),
                          prefixIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.panorama_fisheye_rounded,
                                color: Color(0xFFDFC012)),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 2.h, vertical: 2.h),
                        ),
                      )
                    : Container(),
              ),
              SizedBox(
                height: 0.5.h,
              ),
              Obx(() => controller.paymentMethodt.value == PaymentMethod.custom
                  ? TextFormField(
                      style: TextStyle(fontSize: 8.sp, color: mtGrey800),
                      controller: controller.textFieldcardNo.value,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      onSaved: (String? val) {},
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "No Kartu",
                        filled: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.textFieldcardNo.value.text = '';
                            },
                            icon: const Icon(Icons.clear,
                                color: Color(0xFFDFC012))),
                        // icon: const Icon(Icons.clear),
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.credit_card,
                              color: Color(0xFFDFC012)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 2.h),
                      ),
                    )
                  : Container()),
              SizedBox(
                height: 0.5.h,
              ),
              Obx(() => controller.paymentMethodt.value == PaymentMethod.custom
                  ? TextFormField(
                      style: TextStyle(fontSize: 8.sp, color: mtGrey800),
                      controller: controller.textFieldcardName.value,
                      keyboardType: TextInputType.text,
                      onSaved: (String? val) {},
                      decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: "Pemegang Kartu",
                        filled: true,
                        suffixIcon: IconButton(
                            onPressed: () {
                              controller.textFieldcardName.value.text = '';
                            },
                            icon: const Icon(Icons.clear,
                                color: Color(0xFFDFC012))),
                        // icon: const Icon(Icons.clear),
                        prefixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.account_box,
                              color: Color(0xFFDFC012)),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 2.h, vertical: 2.h),
                      ),
                    )
                  : Container()),
              SizedBox(
                height: 0.5.h,
              ),
              Obx(() => controller.paymentMethodt.value == PaymentMethod.custom
                  ? Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(fontSize: 8.sp, color: mtGrey800),
                            controller: controller.textFieldbatchNo.value,
                            keyboardType: TextInputType.text,
                            onSaved: (String? val) {},
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "No Batch",
                              filled: true,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.textFieldbatchNo.value.text = '';
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Color(0xFFDFC012))),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2.h, vertical: 2.h),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 0.5.h,
                        ),
                        Expanded(
                          child: TextFormField(
                            style: TextStyle(fontSize: 8.sp, color: mtGrey800),
                            controller: controller.textFieldmerchantId.value,
                            keyboardType: TextInputType.text,
                            onSaved: (String? val) {},
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "No Merchant",
                              filled: true,
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.textFieldmerchantId.value.text =
                                        '';
                                  },
                                  icon: const Icon(Icons.clear,
                                      color: Color(0xFFDFC012))),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 2.h, vertical: 2.h),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container()),
              SizedBox(
                height: 0.5.h,
              ),
              Row(
                children: [
                  Expanded(flex: 2, child: pictureSet(context)),
                  SizedBox(
                    width: 2.w,
                  ),
                  Expanded(
                      child: Center(
                    child: generateSubmitButton(),
                  ))
                ],
              )
            ]));
  }

  pictureSet(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 3.h),
      child: SizedBox(
        height: 30.w,
        width: 70.w,
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
                  if (controller.imageReceipt.value.fileName.isNotEmpty) {
                    return Image.file(
                        File(controller.imageReceipt.value.filePath));
                  } else {
                    return const Image(
                      image: AssetImage(noPicImage),
                    );
                  }
                },
              ),
            ),
            Positioned(
              right: -16,
              bottom: -7,
              child: SizedBox(
                height: 6.h,
                width: 10.w,
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
                  },
                  child: Material(
                      elevation: 5,
                      child: SvgPicture.asset("assets/icons/Camera Icon.svg")),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  categoryFieldPayment(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10 / 2),
      height: 30,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: controller.paymentCustList.length,
          itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  // print('work');
                  controller.paymentPo.value.paymentTypeId =
                      controller.paymentCustList[index].id;
                  controller.paymentPo.refresh();
                },
                child: Obx(
                  () => Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: controller.paymentCustList[index].id ==
                                controller.paymentPo.value.paymentTypeId
                            ? primaryYellow
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8)),
                    child:
                        Text(controller.paymentCustList[index].name.toString()),
                  ),
                ),
              )),
    );
  }

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

  imageUploadReceipt(XFile? image) {
    if (image != null) {
      var imagePath = image.path;
      var fileName = (imagePath.split('/').last);
      Get.defaultDialog(
          title: "Ubah Bukti",
          middleText: "Anda akan mengunggah foto bukti pembayaran, lanjutkan?",
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

  TextButton generateSubmitButton() {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryLightGrey),
        elevation: MaterialStateProperty.all(8),
        minimumSize: MaterialStateProperty.all(Size.fromHeight(6.h)),
      ),
      child: Obx(
        () => controller.isSubmit.isFalse
            ? Text(
                'Bayar',
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
      ),
      onPressed: () {
        controller.submitValidate();
      },
    );
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

//  body(context)
  Container body(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: Obx(
          () => controller.listPurchasingCredit.isNotEmpty
              ? ListView.builder(
                  itemCount: controller.listPurchasingCredit.length,
                  itemBuilder: (context, index) {
                    return initListCredit(context, index);
                  })
              : const Center(child: Text("Belum ada data angsuran")),
        ));
  }

  ExpansionTile initListCredit(BuildContext context, int index) {
    return ExpansionTile(
      leading: const Icon(Icons.payment),
      title: Text(
          '${controller.converDateDateToString(controller.listPurchasingCredit[index].createdAt ?? DateTime.now().toString())}'),
      children: [
        ListTile(
            title: Text(controller
                .convertPrice(controller.listPurchasingCredit[index].cost)),
            trailing: Text(
                controller.converDateDateToStringTime(
                    controller.listPurchasingCredit[index].createdAt ??
                        DateTime.now().toString()),
                style: const TextStyle(fontSize: 12, color: Color(0xFF1C9E80))),
            subtitle: Obx(
              () => Text('Pembayaran : ' + controller.getPaymentMethod(index)),
            )),
        controller.listPurchasingCredit[index].pic != null
            ? Image(
                image: CachedNetworkImageProvider(
                    controller.listPurchasingCredit[index].pic!),
              )
            : const Image(
                image: AssetImage(avatarImage),
              ),
      ],
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
              "Angsuran " + controller.listPoproduct.value.note!,
              style: TextStyle(color: Colors.white, fontSize: 9.sp),
            ),
          ),
          // Expanded(
          //     // flex: 3,
          //     child: generateSubmitButton())
        ],
      ),
    );
  }
}
