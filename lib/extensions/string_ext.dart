// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// extension AppStringExt on String {
//   bool get isURL => (Uri.tryParse(this) ?? Uri()).host.isNotEmpty;
//   bool get isAssetPath => toLowerCase().startsWith("assets/");

//   String? get nullOnEmpty => isEmpty ? null : this;

//   void showToast() async {
//     final msj = trim();
//     if (msj.isEmpty) return;
//     await Fluttertoast.cancel();
//     Fluttertoast.showToast(
//       msg: msj,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.black,
//       textColor: Colors.white,
//       fontSize: 14.0,
//     );
//   }
// }
