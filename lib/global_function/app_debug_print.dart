import 'package:flutter/foundation.dart';

class AppDebug {
  printDebug({required String msg}) {
    if (kDebugMode) {
      print(msg);
    }
  }
}
