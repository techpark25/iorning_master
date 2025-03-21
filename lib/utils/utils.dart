import 'package:intl/intl.dart';

class MyAppDateUtils {
  static String formatDate(DateTime date) {
    String monthAbbrev = DateFormat('MMMyy').format(date).toUpperCase();

    String day = DateFormat('dd').format(date);

    String dayName = DateFormat('EEEE').format(date);

    return '$monthAbbrev $day $dayName';
  }

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static String formattime(DateTime timeformat) {
    String time = DateFormat('h:mm a').format(timeformat);

    return time;
  }
}
