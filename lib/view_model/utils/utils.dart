import 'package:intl/intl.dart';

class Utils {
  static String dateFormate(DateTime dateTime) {
    final DateFormat formatter = DateFormat('yMMMMd');
    final String formatted = formatter.format(dateTime);
    return formatted;
  }
}
