class DateUtils {
  static DateTime getDateTimeFromTimestamp(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  }

  static DateTime? getDateTimeFromString(String? dateTime) {
    if (dateTime == null) return null;
    return DateTime.parse(dateTime);
  }
}