import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/constans/values.dart';
import 'package:siangmalam/constans/form_values.dart';
import 'package:siangmalam/commons/custom_style.dart';
import 'package:siangmalam/widgets/custom_button.dart';
import 'package:siangmalam/commons/functions/general_util.dart';
import 'package:siangmalam/commons/controllers/home/attendance_history_controller.dart';
import 'package:siangmalam/screens/home/pages/attendance/pages/components/time_panel.dart';
import 'package:siangmalam/screens/home/pages/attendance/pages/components/date_filter_panel.dart';

/* Created By Dwi Sutrisno */

class AttendanceHistoryBody extends GetView<AttendanceHistoryController> {
  const AttendanceHistoryBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 13.h),
      width: 100.w,
      child: Column(
        children: [
          const DateFilterPanel(),
          SizedBox(
            height: 2.h,
          ),
          Obx(() {
            //get Data From Content Object
            var data = controller.presenceData.value.content;
            //Get Data Array Length
            var dataLength = data?.length ?? 0;
            if (controller.isDataLoad.value) {
              return RefreshIndicator(
                onRefresh: () async {
                  controller.getUserPresenceData(controller.reqStartDate.value, controller.reqEndDate.value);
                },
                color: primaryYellow,
                backgroundColor: mtGrey50,
                child: ConstrainedBox(
                  constraints: BoxConstraints.expand(height: 70.h, width: 100.w),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.zero,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: dataLength,
                        itemBuilder: (BuildContext context, int index) {
                          var presenceData = data![index];
                          var checkIn = presenceData.checkIn ?? GeneralUtils().convertoIsoString(DateTime.now());
                          var checkOut = presenceData.checkOut ?? '-';
                          var workingTimes = presenceData.workingTimes ?? 0;
                          var checkInLocation = presenceData.inlocation ?? '-';
                          var checkOutLocation = presenceData.outLocation ?? '-';
                          var note = presenceData.note ?? '-';
                          var workingHours = GeneralUtils().convertMinutesToHourString(workingTimes);

                          /*Format Date Time */
                          var checkInVal = GeneralUtils().formatDate('HH:mm', checkIn);
                          var checkInDateVal = GeneralUtils().formatDate('dd MMMM yyyy', checkIn);
                          var checkOutVal = '-';
                          if (presenceData.checkOut != null) {
                            checkOutVal = GeneralUtils().formatDate('HH:mm', checkOut);
                          }

                          return TimePanels(
                            dateTitle: checkInDateVal,
                            checkInTime: checkInVal,
                            checkOutTime: checkOutVal,
                            workingHours: workingHours,
                            checkInLocation: checkInLocation,
                            checkOutLocation: checkOutLocation,
                            note: note,
                          );
                        }),
                  ),
                ),
              );
            }

            if (!controller.isDataLoad.value && !controller.isError.value) {
              return const CircularProgressIndicator();
            }

            if (controller.isError.value) {
              return Column(
                children: [
                  Container(
                    child: Text(
                      errorGetData,
                      style: panelTitleTextSytle,
                    ),
                    margin: EdgeInsets.only(top: 2.h),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 2.h),
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: CustomButton(
                      text: brnReloadTxt,
                      icon: Icons.refresh,
                      press: () {
                        controller.getUserPresenceData(controller.reqStartDate.value, controller.reqEndDate.value);
                      },
                    ),
                  )
                ],
              );
            }
            return Text(controller.startDate.value);
          }),
        ],
      ),
    );
  }
}
