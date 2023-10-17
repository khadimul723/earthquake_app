import 'package:intl/intl.dart';


String getFormattedDate(num dt, {String pattern = 'MMM dd yyyy'}) =>
    DateFormat(pattern)
        .format(DateTime.fromMillisecondsSinceEpoch(dt.toInt()));