import 'package:flutter/material.dart';
import '../functions/tasks_page_func.dart';
import '../functions/popuptask_func.dart';
import '../../Theme/themes.dart';
import 'package:flutter/cupertino.dart';
import '../../calendar/functions/calendarFunc.dart';

class NewTaskPopup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewTaskPopupState();
}

class NewTaskPopupState extends State<NewTaskPopup> {
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
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 14 - 80,
                        child: TextFormField(
                          decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Title'),
                          onChanged: (value) {
                            curr_title = value;
                          },
                        ),
                      ),
                      Spacer(),
                      SizedBox(
                        width: 40,
                        child: RawMaterialButton(
                          onPressed: () => colorPicker(),
                          elevation: 0.0,
                          fillColor: usedColor,
                          child: Container(),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                        ),
                      ),
                    ],
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
                      value: isAllDay,
                      onChanged: (value) {
                        setState(() {
                          isAllDay = !isAllDay; //revert state
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
                          !isAllDay, //if All-Day option is opted in, don't show time
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
                          !isAllDay, //if All-Day option is opted in, don't show time
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                        padding: EdgeInsets.only(left: 7.0),
                        child:
                            Text(repeatText, style: TextStyle(fontSize: 15))),
                    Spacer(),
                    Switch(
                      value: isRepeat,
                      onChanged: (value) {
                        setState(() {
                          isRepeat = !isRepeat; //revert state
                          repeatText = repeatTextAssign(value);
                        });
                      },
                      activeColor: buttonColor,
                    ),
                  ],
                ),
                repeatWidget(),
                Padding(
                  padding: EdgeInsets.only(left: 7.0, right: 7.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        border: UnderlineInputBorder(), labelText: 'Location'),
                    onChanged: (value) {
                      curr_location = value;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 7.0, right: 7.0),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      labelText: 'Notes',
                    ),
                    onChanged: (value) {
                      curr_notes = value;
                    },
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

  var typeStatus = [Colors.white, Colors.white, buttonColor];

  Widget taskTypeChooser() {
    return Row(
      children: [
        Spacer(),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: buttonColor!),
            color: typeStatus[0],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
          ),
          child: TextButton(
            onPressed: () {
              setState(() {
                if (typeStatus[0] != buttonColor) {
                  typeStatus[0] = buttonColor;
                } //change selection if not already selected
                if (typeStatus[1] != Colors.white) {
                  typeStatus[1] = Colors.white;
                }
                if (typeStatus[2] != Colors.white) {
                  typeStatus[2] = Colors.white;
                }
              });
            },
            child: const Text('Task'),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: buttonColor!),
            color: typeStatus[1],
          ),
          child: TextButton(
            onPressed: () {
              setState(() {
                if (typeStatus[0] != Colors.white) {
                  typeStatus[0] = Colors.white;
                } //same as above
                if (typeStatus[1] != buttonColor) {
                  typeStatus[1] = buttonColor;
                }
                if (typeStatus[2] != Colors.white) {
                  typeStatus[2] = Colors.white;
                }
              });
            },
            child: const Text('Goal'),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: buttonColor!),
            color: typeStatus[2],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
          ),
          child: TextButton(
            onPressed: () {
              setState(() {
                if (typeStatus[0] != Colors.white) {
                  typeStatus[0] = Colors.white;
                } //same as above
                if (typeStatus[1] != Colors.white) {
                  typeStatus[1] = Colors.white;
                }
                if (typeStatus[2] != buttonColor) {
                  typeStatus[2] = buttonColor;
                }
              });
            },
            child: const Text('Appointment'),
          ),
        ),
        Spacer(),
      ],
    );
  }

  repeatWidget() {
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
                Text(repeatOptionsHourText, style: TextStyle(fontSize: 15)),
              ],
            ),
            leading: Radio<repeatOptionType>(
              value: repeatOptionType.hour,
              groupValue: chosenRepeatOptionType,
              onChanged: (repeatOptionType? value) {
                setState(() {
                  chosenRepeatOptionType = value;
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
                    items: repeatOptionsDay.map((repeatOptionsDayPos) {
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
                Text(repeatOptionsDayText, style: TextStyle(fontSize: 15)),
              ],
            ),
            leading: Radio<repeatOptionType>(
              value: repeatOptionType.day,
              groupValue: chosenRepeatOptionType,
              onChanged: (repeatOptionType? value) {
                setState(() {
                  chosenRepeatOptionType = value;
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
                    items: repeatOptionsWeek.map((repeatOptionsWeekPos) {
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
                Text(repeatOptionsWeekText, style: TextStyle(fontSize: 15)),
              ],
            ),
            leading: Radio<repeatOptionType>(
              value: repeatOptionType.week,
              groupValue: chosenRepeatOptionType,
              onChanged: (repeatOptionType? value) {
                setState(() {
                  chosenRepeatOptionType = value;
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
                    items: repeatOptionsMonth.map((repeatOptionsMonthPos) {
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
                Text(repeatOptionsMonthText, style: TextStyle(fontSize: 15)),
              ],
            ),
            leading: Radio<repeatOptionType>(
              value: repeatOptionType.month,
              groupValue: chosenRepeatOptionType,
              onChanged: (repeatOptionType? value) {
                setState(() {
                  chosenRepeatOptionType = value;
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
                Text(repeatOptionsYearText, style: TextStyle(fontSize: 15)),
              ],
            ),
            leading: Radio<repeatOptionType>(
              value: repeatOptionType.year,
              groupValue: chosenRepeatOptionType,
              onChanged: (repeatOptionType? value) {
                setState(() {
                  chosenRepeatOptionType = value;
                });
              },
            ),
          ),
        ],
      ),
      visible: isRepeat, //if Repeat option is opted in, show repeat options
    );
  }

  colorPicker() {
    return showDialog(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
        title: Center(child: Text('pick a color')),
        children: [
          Center(
            child: Container(
              width: 300/*MediaQuery.of(context).copyWith().size.width - 800*/,
              height: 130/*MediaQuery.of(context).copyWith().size.width - 500*/,
              child: Row(
                children: [
                  Spacer(),
                  Column(
                    children: [
                      colorColumn(0, availableColors),
                      colorColumn(1, availableColors),
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  colorColumn(d1, colors) {
    return Row(
      children: [
        colorBox(d1, 0, colors),
        colorBox(d1, 1, colors),
        colorBox(d1, 2, colors),
        colorBox(d1, 3, colors),
      ],
    );
  }

  colorBox(d1, d2, colors) {
    return SizedBox(
      width: 60,
      child: RawMaterialButton(
        onPressed: () {
          setState(() {
            usedColor = colors[d1][d2];
            Navigator.pop(context, true);
          });
        },
        elevation: 0.0,
        fillColor: colors[d1][d2],
        child: Container(),
        padding: EdgeInsets.all(15.0),
        shape: CircleBorder(),
      ),
    );
  }
}
