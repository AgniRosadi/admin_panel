import 'package:intl/intl.dart';

///Date and time utils
class CsiDate {
  ///Default format yyyy-MM-dd HH:mm:ss, set string format on parameter for custom format
  static String getCurrentDateTime([String format = "yyyy-MM-dd HH:mm:ss"]) {
    try {
      DateTime now = DateTime.now();
      String res = DateFormat(format).format(now);
      return res;
    } catch (e) {
      return "";
    }
  }

  ///Format yyyy-MM-dd, for custom format use CsiDate.getCurrentDateTime(format);
  static String getCurrentDate() {
    try {
      DateTime now = DateTime.now();
      String res = DateFormat("yyyy-MM-dd").format(now);
      return res;
    } catch (e) {
      return "";
    }
  }

  ///Format HH:mm:ss, for custom format use CsiDate.getCurrentDateTime(format);
  static String getCurrentTime() {
    try {
      DateTime now = DateTime.now();
      String res = DateFormat("HH:mm:ss").format(now);
      return res;
    } catch (e) {
      return "";
    }
  }

  ///Get current day
  static int getCurrentDay() {
    try {
      DateTime now = DateTime.now();
      int res = now.day;
      return res;
    } catch (e) {
      return 0;
    }
  }

  ///Month start from 1 end at 12
  static int getCurrentMonth() {
    try {
      DateTime now = DateTime.now();
      int res = now.month;
      return res;
    } catch (e) {
      return 0;
    }
  }

  ///Get current year
  static int getCurrentYear() {
    try {
      DateTime now = DateTime.now();
      int res = now.year;
      return res;
    } catch (e) {
      return 0;
    }
  }

  ///Get todal day of current month
  static int getCurrentTotalDayOfMonth() {
    DateTime firstOfNextMonth;
    if (getCurrentMonth() == 12) {
      firstOfNextMonth = DateTime(getCurrentYear() + 1, 1, 1, 12); //year, month, day, hour
    } else {
      firstOfNextMonth = DateTime(getCurrentYear(), getCurrentMonth() + 1, 1, 12);
    }
    int numberOfDaysInMonth = firstOfNextMonth.subtract(const Duration(days: 1)).day;
    return numberOfDaysInMonth;
  }

  ///Get todal day of selected month and year
  static int getTotalDayOfMonth(int month, int year) {
    DateTime firstOfNextMonth;
    if (month == 12) {
      firstOfNextMonth = DateTime(year + 1, 1, 1, 12); //year, month, day, hour
    } else {
      firstOfNextMonth = DateTime(year, month + 1, 1, 12);
    }
    int numberOfDaysInMonth = firstOfNextMonth.subtract(const Duration(days: 1)).day;
    return numberOfDaysInMonth;
  }

  ///Get DateTime class from provided 'datetime' and 'format', 'format' should same with provided 'datetime'
  static DateTime? stringToDateTime(String datetime, String format) {
    DateFormat dtformat = DateFormat(format);
    try {
      return dtformat.parse(datetime);
    } catch (e) {
      return null;
    }
  }

  ///Get String from provided 'datetime' and 'format', default 'format' = yyyy-MM-dd HH:mm:ss
  static String dateTimeToString(DateTime? datetime, [String format = "yyyy-MM-dd HH:mm:ss"]) {
    try {
      if (datetime == null) {
        return "";
      } else {
        DateFormat dtformat = DateFormat(format);
        String res = dtformat.format(datetime);
        return res;
      }
    } catch (e) {
      return "";
    }
  }
}
