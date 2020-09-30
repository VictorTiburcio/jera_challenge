class DateFormatter {
  static String dateToString(DateTime dateTime, String format) {
    format = format.trim();
    if (dateTime.day < 10) {
      format = format.replaceFirst('dd', '0${dateTime.day}');
    } else {
      format = format.replaceFirst('dd', '${dateTime.day}');
    }
    if (dateTime.month < 10) {
      format = format.replaceFirst('MM', '0${dateTime.month}');
    } else {
      format = format.replaceFirst('MM', '${dateTime.month}');
    }
    format = format.replaceFirst('MM', '${dateTime.month}');
    format = format.replaceFirst('yyyy', '${dateTime.year}');
    return format;
  }
}
