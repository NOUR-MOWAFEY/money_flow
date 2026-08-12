import 'package:intl/intl.dart';

class DateFormatter {
  static String dateFormatter(DateTime date) {
    return DateFormat('dd-MM-yyyy').format(date);
  }

  static String get dateNow {
    return DateFormat('dd-MM-yyyy').format(DateTime.now());
  }
}
