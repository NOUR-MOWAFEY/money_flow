import 'package:intl/intl.dart';

class DateFormatter {
  static String dmy(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String ddmy(DateTime date) {
    return DateFormat('EEE, dd-MM-yyyy').format(date);
  }

  static String get dateNow {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }
}
