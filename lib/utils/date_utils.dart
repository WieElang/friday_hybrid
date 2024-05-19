import 'package:intl/intl.dart';

class DateUtils {
  static DateTime getDateTimeFromTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  static DateTime? getDateTimeFromString(String? dateTime) {
    if (dateTime == null) return null;
    return DateTime.parse(dateTime);
  }

  static String formatToDisplayString(DateTime dateTime, {String format = "EEEE, dd MMMM yyyy"}) {
    final DateFormat formatter = DateFormat(format);
    return formatter.format(dateTime);
  }
}