import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/commons/custom_style.dart';
import 'package:siangmalam/constans/form_values.dart';
import 'package:siangmalam/widgets/custom_button.dart';
import 'package:siangmalam/commons/controllers/home/attendance_controller.dart';

/* Created By Dwi Sutrisno */

class AttendancePanel extends GetView<AttendanceController> {
  const AttendancePanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Positioned(
        bottom: 1.h,
        child: SizedBox(
          width: 100.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              timePanel(),
              controller.isCheckOut.value
                  ? durationPanel()
                  : const SizedBox(
                      height: 0,
                    ),
              locationPanel(),
              accurationPanel(),
              checkInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Padding checkInButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.3.h),
      child: CustomButton(
        text: controller.buttonType.value,
        icon: Icons.arrow_forward_ios,
        press: () async {
          controller.checkButtonSubmit();
        },
      ),
    );
  }

  Container accurationPanel() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: const BoxDecoration(
          color: whiteBg,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              color: Colors.grey,
              spreadRadius: 1,
              offset: Offset(0, 4),
            )
          ]),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
            child: const Icon(Icons.my_location),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lableJarakTxt, style: panelaSubTitleTextSytle),
              Text(
                '${controller.distanceFrmWorkPlace.toStringAsPrecision(2)} meter',
                style: panelContentTextSytle,
              ),
            ],
          )
        ],
      ),
    );
  }

  Container locationPanel() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      decoration: const BoxDecoration(color: whiteBg, boxShadow: [
        BoxShadow(
          blurRadius: 3,
          color: Colors.grey,
          spreadRadius: 1,
          offset: Offset(0, 4),
        )
      ]),
      child: Row(
        children: [
          Container(padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h), child: const Icon(Icons.location_on)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(lableLokasiTxt, style: panelaSubTitleTextSytle),
              Text(
                controller.street.value,
                style: panelContentTextSytle,
              ),
            ],
          )
        ],
      ),
    );
  }

  Container durationPanel() {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 5.w,
      ),
      decoration: const BoxDecoration(color: whiteBg, boxShadow: [
        BoxShadow(
          blurRadius: 3,
          color: Colors.grey,
          spreadRadius: 1,
          offset: Offset(0, 4),
        )
      ]),
      child: Row(
        children: [
          Container(padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h), child: const Icon(Icons.pending_actions)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(workHourPresenceLbl, style: panelaSubTitleTextSytle),
              Text(
                '${controller.workingHour.value} jam',
                style: panelContentTextSytle,
              ),
            ],
          )
        ],
      ),
    );
  }

  Container timePanel() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: const BoxDecoration(
        color: whiteBg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [BoxShadow(blurRadius: 3, color: Colors.grey, spreadRadius: 1, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h), child: const Icon(Icons.watch_later)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Waktu",
                style: panelaSubTitleTextSytle,
              ),
              Text(
                "${controller.dayOfWeek}, ${controller.hour.value}:${controller.minute.value}  ${controller.dates.value}",
                style: panelContentTextSytle,
              )
            ],
          )
        ],
      ),
    );
  }
}
