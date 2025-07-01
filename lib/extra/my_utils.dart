import 'dart:developer';
import 'package:flutter/foundation.dart';

class MyUtils {

  static Future<void> showPrint(String msg) async {
    log(msg);
  }

  static Future<void> printLog(String msg) async {
    if (kDebugMode) {
      print(msg);
    }
  }
}
