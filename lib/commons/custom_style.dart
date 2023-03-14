//outline constan value
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:siangmalam/constans/colors.dart';
import 'package:table_calendar/table_calendar.dart';

//custom outline input border
OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(28),
  borderSide: const BorderSide(color: primaryGrey),
  gapPadding: 10,
);

//custom text style
const TextStyle inputLabelStyle = TextStyle(color: primaryGrey);
const TextStyle errorTextStyle = TextStyle(color: Colors.red);
TextStyle appBarTitleStyle = TextStyle(color: mtGrey800, fontSize: 16.sp, fontWeight: FontWeight.bold);
TextStyle panelTitleTextSytle = TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: mtGrey700);
TextStyle panelContentTextSytle = TextStyle(fontSize: 10.sp, color: mtGrey700, fontWeight: FontWeight.w500);
TextStyle panelaSubTitleTextSytle = TextStyle(fontSize: 10.sp, color: mtGrey700, fontWeight: FontWeight.w600);

//padding
const double inputHorizontalPadding = 25;
const double inputVerticalPadding = 15;

//shadow values
BoxShadow boxShadowStyle = BoxShadow(
  color: Colors.grey.withOpacity(0.5),
  spreadRadius: 3,
  blurRadius: 7,
  offset: const Offset(0, 3), // changes position of shadow
);

//Appbar
OutlinedBorder roundedIconBtnStyleBorder = RoundedRectangleBorder(borderRadius: BorderRadius.circular(50));

//calendar styling values
var calendarHeaderStyle = HeaderStyle(
  titleTextStyle: const TextStyle(color: mtGrey700, fontSize: 20.0),
  decoration: const BoxDecoration(
    color: primaryYellow,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(10),
      topRight: Radius.circular(10),
    ),
  ),
  formatButtonTextStyle: TextStyle(color: mtRed600, fontSize: 12.sp),
  formatButtonDecoration: const BoxDecoration(
    color: mtGrey500,
    borderRadius: BorderRadius.all(
      Radius.circular(5),
    ),
  ),
  leftChevronIcon: const Icon(
    Icons.chevron_left,
    color: mtGrey700,
    size: 28,
  ),
  rightChevronIcon: const Icon(
    Icons.chevron_right,
    color: mtGrey700,
    size: 28,
  ),
);

const calendarStyle = CalendarStyle(
  outsideDaysVisible: false,
  // Weekend dates color (Sat & Sun Column)
  weekendTextStyle: TextStyle(color: mtRed600),
  // highlighted color for today
  todayDecoration: BoxDecoration(
    color: mtGrey500,
    shape: BoxShape.circle,
  ),
  // highlighted color for selected day
  selectedDecoration: BoxDecoration(
    color: primaryYellow,
    shape: BoxShape.circle,
  ),
);

const daysOfTheWeekStyle = DaysOfWeekStyle(
  weekendStyle: TextStyle(color: mtRed600),
);
