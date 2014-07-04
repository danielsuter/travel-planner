library date_util;
import 'package:intl/intl.dart';

class DateUtil {
  static final DateFormat DATE_FORMAT = new DateFormat("dd.MM.yyyy");
  
  static bool isValidDate(String dateAsString) {
    try {
      DATE_FORMAT.parse(dateAsString);
      return true;
    } on FormatException catch(e, stacktrace) {
      return false;
    }
  }  
}