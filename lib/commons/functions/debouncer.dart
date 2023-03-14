import 'dart:async';
import 'package:flutter/foundation.dart';

/* Created By Dwi Sutrisno */

//Debouncer/Anti DDOS
class Debouncer {
  final int milliseconds;
  // ignore: prefer_function_declarations_over_variables
  VoidCallback action = () {};
  Timer timer = Timer(const Duration(seconds: 1), () {});

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    // ignore: unnecessary_null_comparison
    if (timer != null) {
      timer.cancel();
    }
    timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  runWithDelay(int delay, VoidCallback action) {
    // ignore: unnecessary_null_comparison
    if (timer != null) {
      timer.cancel();
    }
    timer = Timer(Duration(milliseconds: delay), action);
  }
}


