import 'package:intl/intl.dart';

class MyAppDateUtils {
  static String formatDate(DateTime date) {
    String monthAbbrev = DateFormat('MMMyy').format(date).toUpperCase();

    String day = DateFormat('dd').format(date);

    String dayName = DateFormat('EEEE').format(date); 

    return '$monthAbbrev $day $dayName';
  }


  static String formattime(DateTime timeformat) {
 

    String time = DateFormat('h:mm a').format(timeformat);

    return time;
  }
}
