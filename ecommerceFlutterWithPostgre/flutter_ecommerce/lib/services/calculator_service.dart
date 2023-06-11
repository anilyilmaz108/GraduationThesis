import 'package:intl/intl.dart';

class CalculatorService {
  static String dateTimeToString(DateTime dateTime) {
    String formattedDate = DateFormat('EEEEE, d MMMM', 'tr_TR').format(dateTime);
    return formattedDate;
  }

  static String profileDateTimeToString(DateTime? dateTime) {
    String formattedDate = DateFormat('dd MMM yyyy, kk:mm', 'tr_TR').format(dateTime!);
    return formattedDate;
  }
}