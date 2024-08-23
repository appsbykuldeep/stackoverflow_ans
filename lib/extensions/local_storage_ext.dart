// import 'package:get_storage/get_storage.dart';

// final _localStorage = GetStorage();

// extension LocalStoreExt on String {
//   String get boxLoginStatus => findindb("boxLoginStatus1");
//   String get boxUserId => findindb("boxUserId");
//   String get boxUserPasswrod => findindb("boxUserPasswrod");
//   String get boxUserToken => findindb("boxUserToken");
//   String get boxIPAddress => findindb("boxIPAddress");
//   String get boxdeviceToken => findindb("boxdeviceToken");

//   void get clearLogUserData {
//     boxUserId;
//     boxUserPasswrod;
//     boxUserToken;
//     boxLoginStatus;
//   }

//   String findindb(String key) {
//     if (isNotEmpty) {
//       if (this == "--") {
//         _localStorage.remove(key);
//       } else {
//         _localStorage.write(key, this);
//       }
//     } else {
//       return _localStorage.read<String>(key) ?? '';
//     }

//     return "";
//   }
// }

// bool get boxLoginStatus => "".boxLoginStatus == "1";
