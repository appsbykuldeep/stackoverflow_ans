import 'package:intl/intl.dart';

extension AppDateTimeExt on DateTime {
  String get toddMMyyformat => formatDate("dd-MMM-yyy");
  String get toddMMformat => formatDate("dd MMM");
  String get toMMMDDYYYYformat => formatDate("MMM dd,yyyy");
  String get toMMMDDYYYYHHMMformat => formatDate("MMM dd,yyyy hh:mm a");

  String get toddmmyyyyhmformat => formatDate("dd-MMM-yyy hh:mm a");

  String get gtTimehhmmformat => formatDate("hh:mm");

  String get gtTimehhmmAPformat => formatDate("hh:mma");

  String get tommmyyyyformat => formatDate("MMM-yyy");
  String get dateTimeddmmyyyyhhmm => formatDate("dd/MM/yyyy hh:mm:ss a");

  String get tommmmyyyyformat => formatDate("MMMM-yyy");

  String get datemmmmformat => formatDate("MMMM");

  String get toapiformat => formatDate("dd/MM/yyyy");
  String get toStandered => formatDate("yyyy-MM-dd");
  String get toYMD => formatDate("y-MMM-d");
  String get toYMDA => formatDate("d MMM y hh:mm a");

  String get toDashboardDate =>
      "Date: $toapiformat\t\tTime: $gtTimehhmmAPformat";

  String get gtDateStanderedformat => formatDate("yyyy-MM-dd");

  String formatDate(String format) {
    return DateFormat(format, "en_US").format(this);
  }

  DateTime get dateOnly => DateTime(year, month, day);
  DateTime get removeMili => DateTime(year, month, day, hour, minute, second);

  String get dayName => switch (weekday) {
        1 => "Monday",
        2 => "Tuesday",
        3 => "Wednesday",
        4 => "Thursday",
        5 => "Friday",
        6 => "Saturday",
        7 => "Sunday",
        _ => "",
      };

  int getDiff(DateTime endDate){
    Duration differences = difference(endDate);
    return differences.inDays;
  }
}
