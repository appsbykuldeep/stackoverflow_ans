import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension AppNumExt on num {
  Widget get heightBox => SizedBox(height: toDouble());
  Widget get widthBox => SizedBox(width: toDouble());

  String get currencyText {
    return "₹ ${numberFormat("##,##,###.##")}";
  }

  String get thousentText => numberFormat("##,##,###.##");

  String numberFormat(String format) {
    return NumberFormat(format, "en_US").format(toDouble());
  }
}
