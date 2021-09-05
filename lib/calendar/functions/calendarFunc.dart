import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

var now = DateTime.now();
var formatterMonth = DateFormat('MM');
var formatterYear = DateFormat('yyyy');
var formatterWeekDay = DateFormat('EEEE');
var formatterDay = DateFormat('d');
var formatterYearMonthDay = DateFormat('yyyy-MM-dd');
String chosenMonthStr = 'no month';
int chosenMonth = 0;
var chosenMonthDate = DateTime.now();
var year;
var yearNum;
int dayCounter = 0;
List<int> month = [
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
  -1,
];
List<Color?> dayColor = [
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
  Colors.black87,
];
int monthPosition = 0;

class Task {
  Task(this.title, this.start, this.end, this.importance, this.place,
      this.recColor);
  String title;
  DateTime start;
  DateTime end;
  var importance;
  var place = '';
  Color recColor = Colors.blue;
}

String monthName(int number) {
  switch (number) {
    case -1:
      return 'Error: Number of month invalid. Please submit this issue if this repeats.';
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
  }
  return 'Invalid';
}

int getLastDay(int ofMonth, int year) {
  bool divisible = false;
  if (year % 4 == 0) {
    if (year % 100 == 0) {
      if (year % 400 == 0) {
        divisible = true;
      }
    } else {
      divisible = true;
    }
  }
  switch (ofMonth) {
    case 0:
      return 31;
    case 1:
      return 31;
    case 2:
      return divisible == true ? 29 : 28;
    case 3:
      return 31;
    case 4:
      return 30;
    case 5:
      return 31;
    case 6:
      return 30;
    case 7:
      return 31;
    case 8:
      return 31;
    case 9:
      return 30;
    case 10:
      return 31;
    case 11:
      return 30;
    case 12:
      return 31;
    case 13:
      return 31;
  }
  return -1;
}

var _prevMonthCounter = 0;
var _prevMonthDay;
var _prevMonthPtr;
var _lastDay;
var _nextMonthPtr;
int _forLoop = 0;
var _prevDayCount = 0;

void fillMonth() {
  _prevDayCount = 0;
  for (int i = 0; i < 42; i++) dayColor[i] = Colors.black87;
  //calculate days from last month to display this month
  _prevMonthDay = getLastDay(chosenMonth - 1, yearNum);
  _prevMonthCounter = DateTime(yearNum, chosenMonth, 1).weekday - 1;
  if (DateTime(yearNum, chosenMonth, 1).weekday == 1) _prevMonthCounter = 7;
  _prevMonthPtr = _prevMonthCounter - 1;
  for (_forLoop = 0; _forLoop < _prevMonthCounter; _forLoop++) {
    month[_forLoop] = _prevMonthDay - _prevMonthPtr;
    dayColor[_forLoop] = Colors.grey[500];
    _prevMonthPtr--;
    _prevDayCount++;
  }
  //now add the days from this month to the Array
  _lastDay = getLastDay(chosenMonth, yearNum);
  dayCounter = _prevMonthCounter;
  for (_forLoop = 0; _forLoop < _lastDay; _forLoop++) {
    month[dayCounter] = _forLoop + 1;
    dayCounter++;
  }
  //Now, add the days from the next month to the Array
  _nextMonthPtr = dayCounter;
  for (_forLoop = 0; _forLoop < 42 - dayCounter; _forLoop++) {
    month[_nextMonthPtr] = _forLoop + 1;
    dayColor[_nextMonthPtr] = Colors.grey[500];
    _nextMonthPtr++;
  }
}

int weekInMonth(int day) { //TODO: make this work
  return -1;
}