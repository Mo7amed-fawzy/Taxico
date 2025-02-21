import 'package:intl/intl.dart';
import 'package:taxi_grad/core/extentions/date_time_extension.dart';
import 'package:timeago/timeago.dart' as timeago;

extension StringExtension on String {
  bool get isEmail {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }

  DateTime dataFormat(
      {String format = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", int addMin = 0}) {
    var date = (DateFormat(format).parseUTC(this));
    return date.add(Duration(minutes: addMin));
  }

  String timeAgo() {
    if (this == "") {
      return "";
    }

    return timeago.format(dataFormat());
  }

  String stringFormatToOtherFormat(
      {String format = "yyyy-MM-dd",
      String newFormat = 'dd/MM/yyyy',
      int addMin = 0}) {
    try {
      var date = DateFormat(format).parse(this);

      return date
          .add(Duration(minutes: addMin))
          .stringFormat(format: newFormat);
    } catch (e) {
      return "";
    }
  }

  DateTime get date {
    return DateFormat('yyyy/MM/dd').parse(this);
  }

  DateTime get dateTime {
    return DateFormat('yyyy/MM/dd HH:mm').parse(this);
  }
}
