class DateUtils {
  static DateTime getDateTimeFromTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  static DateTime getDateTimeFromString(String dateTime) {
    return DateTime.parse(dateTime);
  }
}