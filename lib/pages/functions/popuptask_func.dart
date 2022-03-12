import 'package:flutter/material.dart';

import '../../calendar/functions/calendarFunc.dart';

var curr_title;
var curr_location;
var curr_notes;
var isAllDay = false;
var isRepeat = false;
var repeatText = 'Repeat';
var repeatOptionsHourText = '  hour';
var repeatOptionsHour = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11',
  '12',
  '13',
  '14',
  '15',
  '16',
  '17',
  '18',
  '19',
  '20',
  '21',
  '22',
  '23'
];
var repeatOptionsHourSel = '1';
var repeatOptionsDayText = '  day';
var repeatOptionsDay = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6'
]; //make weekdays and month names as well as year names?
var repeatOptionsDaySel = '1';
var repeatOptionsWeekText = '  week';
var repeatOptionsWeek = ['1', '2', '3'];
var repeatOptionsWeekSel = '1';
var repeatOptionsMonthText = '  month';
var repeatOptionsMonth = [
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '10',
  '11'
];
var repeatOptionsMonthSel = '1';
var repeatOptionsYearText = '  year';
var repeatOptionsYearValue;
enum repeatOptionType { hour, day, week, month, year }
repeatOptionType? chosenRepeatOptionType = repeatOptionType.hour;

var availableColors = [
  Colors.red,
  Colors.orange,
  Colors.yellow,
  Colors.blue,
  Colors.green,
  Colors.deepPurple,
  Colors.pink,
  Colors.teal,
];

saveTask() {
  var newTask = Task(
    curr_title,
    DateTime.now(),
    DateTime.now(),
    1,
    curr_location, //TODO: add importance chooser to GUI
    Colors.black, //add that too
  );
}