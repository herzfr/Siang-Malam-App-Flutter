import 'package:flutter/material.dart';
import 'package:siangmalam/constans/colors.dart';

ThemeData theme() {
  return ThemeData(
    dividerColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.red,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    fontFamily: "Poppins",
    appBarTheme: const AppBarTheme(color: Colors.white, elevation: 0, iconTheme: IconThemeData(color: Colors.blue), centerTitle: true),
    inputDecorationTheme: inputDecorationTheme(),
    textTheme: const TextTheme(
      bodyText1: TextStyle(color: primaryGrey),
      bodyText2: TextStyle(color: primaryGrey),
    ),
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder =
      OutlineInputBorder(borderRadius: BorderRadius.circular(28), borderSide: const BorderSide(color: textColor), gapPadding: 10);
  return InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.grey[700]),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder,
      contentPadding: const EdgeInsets.symmetric(horizontal: 42, vertical: 20));
}

Theme datePickerTheme(Widget child) {
  return Theme(
    data: ThemeData.fallback().copyWith(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.amber,
      ),
      dialogBackgroundColor: mtGrey50,
    ),
    child: child,
  );
}
