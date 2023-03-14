import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:siangmalam/commons/custom_style.dart';
import 'package:siangmalam/constans/form_values.dart';

/* Created By Dwi Sutrisno */

class TimePanels extends StatelessWidget {
  const TimePanels({
    Key? key,
    required this.dateTitle,
    required this.checkInTime,
    required this.checkOutTime,
    required this.workingHours,
    required this.checkInLocation,
    required this.checkOutLocation,
    required this.note,
  }) : super(key: key);

  final String dateTitle;
  final String checkInTime;
  final String checkOutTime;
  final String workingHours;
  final String checkInLocation;
  final String checkOutLocation;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      margin: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: primaryYellow,
        boxShadow: [
          boxShadowStyle,
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            dateTitle,
            style: panelTitleTextSytle,
          ),
          SizedBox(
            height: 1.h,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: mtGrey700),
              ),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          _timeLabel(inPresenceLbl, checkInTime),
          _timeLabel(inlocPresenceLbl, checkInLocation),
          SizedBox(
            height: 2.h,
          ),
          _timeLabel(outPresenceLbl, checkOutTime),
          _timeLabel(outlocPresenceLbl, checkOutLocation),
          SizedBox(
            height: 2.h,
          ),
          _timeLabel(workHourPresenceLbl, workingHours),
          _timeLabel(notePresenceLbl, note),
        ],
      ),
    );
  }

  _timeLabel(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: panelaSubTitleTextSytle,
        ),
        SizedBox(
          width: 50.w,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Text(
              content,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: panelContentTextSytle,
            ),
          ),
        ),
      ],
    );
  }
}
