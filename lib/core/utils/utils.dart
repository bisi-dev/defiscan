import 'package:timeago/timeago.dart' as timeago;

class Utils {
  static String convertTime(String timestamp) {
    int timestampInt = int.parse(timestamp);
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestampInt * 1000);
    return timeago.format(time);
  }
}
