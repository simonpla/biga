import 'package:flutter/material.dart';
import '../functions/tasks_page_func.dart';
import '../../Theme/themes.dart';
import 'package:flutter/cupertino.dart';
import '../../calendar/functions/calendarFunc.dart';

class NewTaskPopup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewTaskPopupState();
}

enum repeatOptionType { hour, day, week, month, year }

class NewTaskPopupState extends State<NewTaskPopup> {
  var _isAllDay = false;
  var _isRepeat = false;
  var _repeatText = 'Repeat';
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
  repeatOptionType? _chosenRepeatOptionType = repeatOptionType.hour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Row(
            children: [
              Spacer(),
              IconButton(
                  onPressed: () => Navigator.pop(context), icon: closeIcon),
              Spacer(flex: 80),
              Text('Create new task',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Spacer(flex: 80),
              ElevatedButton(
                  onPressed: () => Navigator.pop(context), child: Text('Save')),
              Spacer(flex: 2),
            ],
          ),
          taskTypeChooser(),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 13.0, right: 13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 7.0, right: 7.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(), labelText: 'Title'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 7.0),
                        child: Text('All-day', style: TextStyle(fontSize: 15))),
                    Spacer(),
                    Switch(
                      value: _isAllDay,
                      onChanged: (value) {
                        setState(() {
                          _isAllDay = !_isAllDay; //revert state
                        });
                      },
                      activeColor: buttonColor,
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(left: 7.0),
                    child: Text('Start', style: TextStyle(fontSize: 15))),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        datePicker(1);
                      },
                      child: Text(
                        '${formatterYearMonthDay.format(selDateStart)}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Spacer(),
                    Visibility(
                      child: TextButton(
                        onPressed: () {
                          timePicker(2);
                        },
                        child: Text(
                          '${formatterHourMinute.format(selDateStart)}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      visible:
                      !_isAllDay, //if All-Day option is opted in, don't show time
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                    padding: EdgeInsets.only(left: 7.0),
                    child: Text('End', style: TextStyle(fontSize: 15))),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {
                        datePicker(3);
                      },
                      child: Text(
                        '${formatterYearMonthDay.format(selDateEnd)}',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Spacer(),
                    Visibility(
                      child: TextButton(
                        onPressed: () {
                          timePicker(4);
                        },
                        child: Text(
                          '${formatterHourMinute.format(selDateEnd)}',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      visible:
                      !_isAllDay, //if All-Day option is opted in, don't show time
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 7.0),
                        child:
                        Text(_repeatText, style: TextStyle(fontSize: 15))),
                    Spacer(),
                    Switch(
                      value: _isRepeat,
                      onChanged: (value) {
                        setState(() {
                          _isRepeat = !_isRepeat; //revert state
                          _repeatText = repeatTextAssign(value);
                        });
                      },
                      activeColor: buttonColor,
                    ),
                  ],
                ),
                Visibility(
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
                                items:
                                repeatOptionsHour.map((repeatOptionsHourPos) {
                                  return DropdownMenuItem(
                                    child: Text(repeatOptionsHourPos),
                                    value: repeatOptionsHourPos,
                                  );
                                }).toList(),
                                onChanged: (index) {
                                  setState(() {
                                    repeatOptionsHourSel = index as String;
                                    if (index == '1') {
                                      repeatOptionsHourText = '  hour';
                                    } else {
                                      repeatOptionsHourText = '  hours';
                                    }
                                  });
                                },
                                focusColor: buttonColor,
                              ),
                            ),
                            Text(repeatOptionsHourText,
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                        leading: Radio<repeatOptionType>(
                          value: repeatOptionType.hour,
                          groupValue: _chosenRepeatOptionType,
                          onChanged: (repeatOptionType? value) {
                            setState(() {
                              _chosenRepeatOptionType = value;
                            });
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
                                items:
                                repeatOptionsDay.map((repeatOptionsDayPos) {
                                  return DropdownMenuItem(
                                    child: Text(repeatOptionsDayPos),
                                    value: repeatOptionsDayPos,
                                  );
                                }).toList(),
                                onChanged: (index) {
                                  setState(() {
                                    repeatOptionsDaySel = index as String;
                                    if (index == '1') {
                                      repeatOptionsDayText = '  day';
                                    } else {
                                      repeatOptionsDayText = '  days';
                                    }
                                  });
                                },
                                focusColor: buttonColor,
                              ),
                            ),
                            Text(repeatOptionsDayText,
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                        leading: Radio<repeatOptionType>(
                          value: repeatOptionType.day,
                          groupValue: _chosenRepeatOptionType,
                          onChanged: (repeatOptionType? value) {
                            setState(() {
                              _chosenRepeatOptionType = value;
                            });
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
                                items:
                                repeatOptionsWeek.map((repeatOptionsWeekPos) {
                                  return DropdownMenuItem(
                                    child: Text(repeatOptionsWeekPos),
                                    value: repeatOptionsWeekPos,
                                  );
                                }).toList(),
                                onChanged: (index) {
                                  setState(() {
                                    repeatOptionsWeekSel = index as String;
                                    if (index == '1') {
                                      repeatOptionsWeekText = '  week';
                                    } else {
                                      repeatOptionsWeekText = '  weeks';
                                    }
                                  });
                                },
                                focusColor: buttonColor,
                              ),
                            ),
                            Text(repeatOptionsWeekText,
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                        leading: Radio<repeatOptionType>(
                          value: repeatOptionType.week,
                          groupValue: _chosenRepeatOptionType,
                          onChanged: (repeatOptionType? value) {
                            setState(() {
                              _chosenRepeatOptionType = value;
                            });
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
                                items: repeatOptionsMonth
                                    .map((repeatOptionsMonthPos) {
                                  return DropdownMenuItem(
                                    child: Text(repeatOptionsMonthPos),
                                    value: repeatOptionsMonthPos,
                                  );
                                }).toList(),
                                onChanged: (index) {
                                  setState(() {
                                    repeatOptionsMonthSel = index as String;
                                    if (index == '1') {
                                      repeatOptionsMonthText = '  month';
                                    } else {
                                      repeatOptionsMonthText = '  months';
                                    }
                                  });
                                },
                                focusColor: buttonColor,
                              ),
                            ),
                            Text(repeatOptionsMonthText,
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                        leading: Radio<repeatOptionType>(
                          value: repeatOptionType.month,
                          groupValue: _chosenRepeatOptionType,
                          onChanged: (repeatOptionType? value) {
                            setState(() {
                              _chosenRepeatOptionType = value;
                            });
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
                                  setState(() {
                                    repeatOptionsYearValue = value;
                                    if (value == '1' || value == '') {
                                      repeatOptionsYearText = '  year';
                                    } else {
                                      repeatOptionsYearText = '  years';
                                    }
                                  });
                                },
                              ),
                            ),
                            Text(repeatOptionsYearText,
                                style: TextStyle(fontSize: 15)),
                          ],
                        ),
                        leading: Radio<repeatOptionType>(
                          value: repeatOptionType.year,
                          groupValue: _chosenRepeatOptionType,
                          onChanged: (repeatOptionType? value) {
                            setState(() {
                              _chosenRepeatOptionType = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  visible:
                  _isRepeat, //if Repeat option is opted in, show repeat options
                ),
                Padding(
                  padding: EdgeInsets.only(left: 7.0, right: 7.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(), labelText: 'Location'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget? datePicker(int id) {
    //return native looking date picker
    final ThemeData theme = Theme.of(context);
    if (theme.platform == TargetPlatform.iOS ||
        theme.platform == TargetPlatform.macOS ||
        iosTest == true) {
      return cupertinoDatePicker(id);
    } else {
      return FutureBuilder(
        future: materialDatePicker(id),
        builder: (context, snapshot) {
          return CircularProgressIndicator();
        },
      );
    }
  }

  materialDatePicker(int id) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: tempDate,
      firstDate: DateTime(1990),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child as Widget,
        );
      },
    );
    if (picked != null && picked != tempDate) {
      setState(() {
        picked = DateTime(
            picked!.year,
            picked!.month,
            picked!.day,
            id == 1 ? selTimeStart.hour : selTimeEnd.hour,
            id == 1 ? selTimeStart.minute : selTimeEnd.minute);
        print(
            '${picked!.year} ${picked!.month} ${picked!.day} ${id == 1 ? selTimeStart.hour : selTimeEnd.hour} ${id == 1 ? selTimeStart.minute : selTimeEnd.minute}');
        assignToDateTime(id, picked);
      });
    }
  }

  cupertinoDatePicker(int id) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 2,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.dateAndTime,
              onDateTimeChanged: (picked) {
                if (picked != tempDate) {
                  setState(() {
                    assignToDateTime(id.isEven ? id - 1 : id, picked);
                  });
                }
              },
              initialDateTime: tempDate,
              minimumYear: 1990,
              maximumYear: 2050,
              use24hFormat: true,
            ),
          );
        });
  }

  Widget? timePicker(int id) {
    //return native looking time picker
    final ThemeData theme = Theme.of(context);
    if (theme.platform == TargetPlatform.iOS ||
        theme.platform == TargetPlatform.macOS ||
        iosTest == true) {
      return cupertinoDatePicker(id);
    } else {
      return FutureBuilder(
        future: materialTimePicker(id),
        builder: (context, snapshot) {
          return CircularProgressIndicator();
        },
      );
    }
  }

  materialTimePicker(int id) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: tempTime,
    );
    if (picked != null) {
      setState(() {
        assignToDateTime(id, picked);
        assignToDateTime(
            id - 1,
            DateTime(tempDate.year, tempDate.month, tempDate.day, picked.hour,
                picked.minute));
        print('$selTimeStart $selTimeEnd');
        print('$selTimeStart $selTimeEnd');
      });
    }
  }

  Widget taskTypeChooser() {
    var _typeStatus = [true, false, false];
    return Row(
      //mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: buttonColor!),
            color: _typeStatus[0] ? buttonColor! : Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
          ),
          //width: 50,
          child: TextButton(
            onPressed: () {
              setState(() {
                if(!_typeStatus[0]) _typeStatus[0] = true; //change selection if not already selected
                if(_typeStatus[1]) _typeStatus[1] = false;
                if(_typeStatus[2]) _typeStatus[2] = false;
              });
            },
            child: const Text('Task'),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: buttonColor!),
            color: _typeStatus[1] ? buttonColor! : Colors.white,
          ),
          //width: 50,
          child: TextButton(
            onPressed: () {
              setState(() {
                if(_typeStatus[0]) _typeStatus[0] = false; //same as above
                if(!_typeStatus[1]) _typeStatus[1] = true;
                if(_typeStatus[2]) _typeStatus[2] = false;
              });
            },
            child: const Text('Goal'),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: buttonColor!),
            color:  _typeStatus[2] ? buttonColor! : Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
          ),
          //width: 100,
          child: TextButton(
            onPressed: () {
              setState(() {
                if(_typeStatus[0]) _typeStatus[0] = false; //sama as above 
                if(_typeStatus[1]) _typeStatus[1] = false;
                if(!_typeStatus[2]) _typeStatus[2] = true;
              });
            },
            child: const Text('Appointment'),
          ),
        ),
        Spacer(),
      ],
    );
  }
}
