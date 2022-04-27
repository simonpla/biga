import 'package:flutter/material.dart';
import '../../../Theme/themes.dart';
import '../popuptask_func.dart';
import '../../functions/tasks_page_func.dart';

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

Widget repeatSwitch() {
  return Row(
    children: [
      Padding(
          padding: EdgeInsets.only(left: 7.0),
          child: Text(repeatText, style: TextStyle(fontSize: 15))),
      Spacer(),
      Switch(
        value: isRepeat,
        onChanged: (value) {
          isRepeat = !isRepeat; //revert state
          repeatText = repeatTextAssign(value);
          setStateNeeded = true;
        },
        activeColor: buttonColor,
      ),
    ],
  );
}

Widget repeatWidget() {
  return Visibility(
    child: Column(
      children: [
        ListTile(
          title: Row(
            children: [
              SizedBox(
                width: 60,
                child: DropdownButton(
                  isExpanded: true,
                  value: repeatOptionsHourSel,
                  items: repeatOptionsHour.map((repeatOptionsHourPos) {
                    return DropdownMenuItem(
                      child: Text(repeatOptionsHourPos),
                      value: repeatOptionsHourPos,
                    );
                  }).toList(),
                  onChanged: (index) {
                    repeatOptionsHourSel = index as String;
                    if (index == '1') {
                      repeatOptionsHourText = repeatOptionsDesc[0];
                    } else {
                      repeatOptionsHourText = repeatOptionsDesc[0] + 's';
                    }
                    setStateNeeded = true;
                  },
                ),
              ),
              Text(repeatOptionsHourText, style: TextStyle(fontSize: 15)),
            ],
          ),
          leading: Radio<repeatOptionType>(
            value: repeatOptionType.hour,
            groupValue: chosenRepeatOptionType,
            onChanged: (repeatOptionType? value) {
              chosenRepeatOptionType = value;
              setStateNeeded = true;
            },
          ),
        ),
        ListTile(
          title: Row(
            children: [
              SizedBox(
                width: 60,
                child: DropdownButton(
                  isExpanded: true,
                  value: repeatOptionsDaySel,
                  items: repeatOptionsDay.map((repeatOptionsDayPos) {
                    return DropdownMenuItem(
                      child: Text(repeatOptionsDayPos),
                      value: repeatOptionsDayPos,
                    );
                  }).toList(),
                  onChanged: (index) {
                    repeatOptionsDaySel = index as String;
                    if (index == '1') {
                      repeatOptionsDayText = repeatOptionsDesc[1];
                    } else {
                      repeatOptionsDayText = repeatOptionsDesc[1] + 's';
                    }
                    setStateNeeded = true;
                  },
                ),
              ),
              Text(repeatOptionsDayText, style: TextStyle(fontSize: 15)),
            ],
          ),
          leading: Radio<repeatOptionType>(
            value: repeatOptionType.day,
            groupValue: chosenRepeatOptionType,
            onChanged: (repeatOptionType? value) {
              chosenRepeatOptionType = value;
              setStateNeeded = true;
            },
          ),
        ),
        ListTile(
          title: Row(
            children: [
              SizedBox(
                width: 60,
                child: DropdownButton(
                  isExpanded: true,
                  value: repeatOptionsWeekSel,
                  items: repeatOptionsWeek.map((repeatOptionsWeekPos) {
                    return DropdownMenuItem(
                      child: Text(repeatOptionsWeekPos),
                      value: repeatOptionsWeekPos,
                    );
                  }).toList(),
                  onChanged: (index) {
                    repeatOptionsWeekSel = index as String;
                    if (index == '1') {
                      repeatOptionsWeekText = repeatOptionsDesc[2];
                    } else {
                      repeatOptionsWeekText = repeatOptionsDesc[2] + 's';
                    }
                    setStateNeeded = true;
                  },
                ),
              ),
              Text(repeatOptionsWeekText, style: TextStyle(fontSize: 15)),
            ],
          ),
          leading: Radio<repeatOptionType>(
            value: repeatOptionType.week,
            groupValue: chosenRepeatOptionType,
            onChanged: (repeatOptionType? value) {
              chosenRepeatOptionType = value;
              setStateNeeded = true;
            },
          ),
        ),
        ListTile(
          title: Row(
            children: [
              SizedBox(
                width: 60,
                child: DropdownButton(
                  isExpanded: true,
                  value: repeatOptionsMonthSel,
                  items: repeatOptionsMonth.map((repeatOptionsMonthPos) {
                    return DropdownMenuItem(
                      child: Text(repeatOptionsMonthPos),
                      value: repeatOptionsMonthPos,
                    );
                  }).toList(),
                  onChanged: (index) {
                    repeatOptionsMonthSel = index as String;
                    if (index == '1') {
                      repeatOptionsMonthText = repeatOptionsDesc[3];
                    } else {
                      repeatOptionsMonthText = repeatOptionsDesc[3] + 's';
                    }
                    setStateNeeded = true;
                  },
                ),
              ),
              Text(repeatOptionsMonthText, style: TextStyle(fontSize: 15)),
            ],
          ),
          leading: Radio<repeatOptionType>(
            value: repeatOptionType.month,
            groupValue: chosenRepeatOptionType,
            onChanged: (repeatOptionType? value) {
              chosenRepeatOptionType = value;
              setStateNeeded = true;
            },
          ),
        ),
        ListTile(
          title: Row(
            children: [
              SizedBox(
                width: 60,
                height: 35,
                child: TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(8),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    repeatOptionsYearValue = value;
                    if (value == '1' || value == '') {
                      repeatOptionsYearText = repeatOptionsDesc[4];
                    } else {
                      repeatOptionsYearText = repeatOptionsDesc[4] + 's';
                    }
                    setStateNeeded = true;
                  },
                ),
              ),
              Text(repeatOptionsYearText, style: TextStyle(fontSize: 15)),
            ],
          ),
          leading: Radio<repeatOptionType>(
            value: repeatOptionType.year,
            groupValue: chosenRepeatOptionType,
            onChanged: (repeatOptionType? value) {
              chosenRepeatOptionType = value;
              setStateNeeded = true;
            },
          ),
        ),
      ],
    ),
    visible: isRepeat, //if Repeat option is opted in, show repeat options
  );
}
