import 'package:flutter/material.dart';

class AppConfig {
  static const String appName = 'Courtly';
  static const Color seedColor = Color(0xFFFF9800);
  static const String noun = 'Booking';

  static const bool usesValue = false;
  static const bool usesFlag = true;
  static const bool tab2Flagged = true;

  static const String valueLabel = 'Amount';
  static const String flagLabel = 'Confirmed';
  static const String detailLabel = 'Venue';
  static const String categoryLabel = 'Sport';

  static const String tab1 = 'Bookings';
  static const String tab2 = 'Confirmed';
  static const String tab3 = 'Insights';
  static const IconData icon1 = Icons.event_note;
  static const IconData icon2 = Icons.verified;
  static const IconData icon3 = Icons.insights;

  // seed rows: [title, detail, value, flag, category]
  static const List<List<Object>> seed = [
    ['Futsal 7PM', 'GOR Cahaya', 0, false, 'Futsal'],
    ['Badminton 6PM', 'Sport Center A', 0, true, 'Badminton'],
    ['Basketball 8PM', 'City Arena', 0, false, 'Basketball'],
    ['Tennis 5PM', 'Green Court', 0, true, 'Tennis'],
    ['Mini Soccer 9PM', 'Field One', 0, false, 'Soccer'],
  ];
}
