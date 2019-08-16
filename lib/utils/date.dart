import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

convertToBr(String date) {
  var dayFormatter = new DateFormat('d');
  var monthFormatter = new DateFormat('MMM');

  var day = dayFormatter.format(DateTime.parse(date)).toString();
  var month = monthFormatter.format(DateTime.parse(date)).toString();

  return day + ' de ' + month;
}
