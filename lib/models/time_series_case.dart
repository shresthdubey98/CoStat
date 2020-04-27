import 'package:flutter/foundation.dart';
class TimeSeriesCase {
  final int dailyConfirmed;
  final int dailyDeceased;
  final int dailyRecovered;
  final int totalConfirmed;
  final int totalDeceased;
  final int totalRecovered;
  final DateTime date;

  TimeSeriesCase({
    @required this.dailyConfirmed,
    @required this.dailyDeceased,
    @required this.dailyRecovered,
    @required this.totalConfirmed,
    @required this.totalDeceased,
    @required this.totalRecovered,
    @required this.date,
  });
}
