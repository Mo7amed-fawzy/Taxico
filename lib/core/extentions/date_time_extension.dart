import 'package:intl/intl.dart' show DateFormat;

extension DateTimeExtension on DateTime {
  String stringFormat({String format = "yyyy-MM-dd"}) {
    return DateFormat(format).format(this);
  }
}
