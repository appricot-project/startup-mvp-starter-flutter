import 'package:flutter/material.dart';

debugPrintLongStr(String longString) {
  int startIndex = 0;
  int endIndex = 900;
  while (startIndex < longString.length) {
    if (endIndex > longString.length) {
      endIndex = longString.length;
    }
    String substring = longString.substring(startIndex, endIndex);
    debugPrint(substring);
    startIndex += 900;
    endIndex += 900;
  }
}
