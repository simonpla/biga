import 'package:aufgabenplaner/calendar/functions/calendarFunc.dart';
import '../../calendar/UI/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import '../../Theme/themes.dart';
import '../functions/tasks_page_func.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with TickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int selected = 3;

  void _handlePressed() {}

  Widget _buildNavigation() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        children: [
          Container(
              height: 30,
              width: MediaQuery.of(context).size.width / 2 > 250
                  ? (MediaQuery.of(context).size.width - 250) / 2 - 10
                  : MediaQuery.of(context).size.width / 4 - 10),
          RowSuper(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: primaryColorL,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(19),
                    topLeft: Radius.circular(19),
                  ),
                ),
                height: 40,
                width: MediaQuery.of(context).size.width / 2 > 250
                    ? 250
                    : MediaQuery.of(context).size.width / 2,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 > 250
                          ? 50
                          : MediaQuery.of(context).size.width / 10,
                      height: 10,
                    ),
                    Container(
                      child: IconButton(
                        icon: menuIcon,
                        onPressed: () => scaffoldKey.currentState!.openDrawer(),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 > 250
                          ? 50
                          : MediaQuery.of(context).size.width / 10,
                      height: 10,
                    ),
                    Container(
                      child: IconButton(
                        icon: searchIcon,
                        onPressed: () => null,
                      ),
                    ),
                  ],
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  showDialog(context: context, builder: (_) => NewTaskPopup());
                },
                child: plusIcon,
                backgroundColor: buttonColor,
              ),
            ],
            innerDistance: -8,
          ),
        ],
      ),
    );
  }

  Widget _menu() {
    return Drawer(
      child: Container(
        color: uBackground,
        child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 170,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: accentColor,
                ),
                child: Column(
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Foo Bar Baz'),
                      ),
                    ),
                    Container(height: 10.0),
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('foo.bar.baz@example.com'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Container(
                child: taskIcon,
              ),
              title: Text('Tasks', style: TextStyle(color: uTextColor)),
              onTap: () => Navigator.pushNamed(context, '/tasks'),
              hoverColor: hoverColorL,
            ),
            ListTile(
              leading: Container(
                child: chatIcon,
              ),
              title: Text('Chat', style: TextStyle(color: uTextColor)),
              onTap: () => Navigator.pushNamed(context, '/chat'),
              hoverColor: hoverColorL,
            ),
            ListTile(
              leading: Container(
                child: notesIcon,
              ),
              title: Text('Notes', style: TextStyle(color: uTextColor)),
              onTap: () => Navigator.pushNamed(context, '/notes'),
              hoverColor: hoverColorL,
            ),
            ListTile(
              leading: Container(
                child: contactIcon,
              ),
              title: Text('Contacts', style: TextStyle(color: uTextColor)),
              onTap: () => Navigator.pushNamed(context, '/contacts'),
              hoverColor: hoverColorL,
            ),
            ListTile(
              leading: Container(
                child: settingsIcon,
              ),
              title: Text('Settings', style: TextStyle(color: uTextColor)),
              onTap: () => Navigator.pushNamed(context, '/settings'),
              hoverColor: hoverColorL,
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    List<String> items = [
      'appointments',
      'day',
      'week',
      'month'
    ]; //TODO: consider replacing appointments with schedule

    return AppBar(
      backgroundColor: accentColor,
      elevation: 0,
      leading: Container(
        width: 20,
      ),
      title: Container(
        child: RowSuper(
          children: [
            MediaQuery.of(context).size.width > 800
                ? Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                      color: iconColor,
                      icon: starIcon,
                      onPressed: () => null,
                    ),
                  )
                : null,
            MediaQuery.of(context).size.width > 670
                ? Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                      color: iconColor,
                      icon: starIcon,
                      onPressed: () => null,
                    ),
                  )
                : null,
            MediaQuery.of(context).size.width > 550
                ? Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                      color: iconColor,
                      icon: starIcon,
                      onPressed: () => null,
                    ),
                  )
                : null,
            MediaQuery.of(context).size.width > 300
                ? Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                      color: iconColor,
                      icon: starIcon,
                      onPressed: () => null,
                    ),
                  )
                : null,
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: IconButton(
                color: iconColor,
                icon: starIcon,
                onPressed: () => null,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: PopupMenuButton<int>(
                offset: Offset(60, 30),
                color: menuBackgroundL,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Center(child: calendarIcon),
                itemBuilder: (context) {
                  return List.generate(4, (index) {
                    return PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(iconsMenuChooseCalendarLayout[index],
                              color: iconColor),
                          Container(width: 13),
                          Text(items[index]),
                        ],
                      ),
                    );
                  });
                },
                onSelected: (int index) {
                  setState(() {
                    selected = index;
                  });
                },
              ),
            ),
          ],
          innerDistance: MediaQuery.of(context).size.width > 400 ? 80 : 30,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget getCalendarBody() {
    switch (selected) {
      case 0:
        return Container();
      case 1:
        return Container();
      case 2:
        return Week();
      case 3:
        return Month();
    }
    return Text('Error: wrong body: $selected',
        style: TextStyle(color: errorColor, fontSize: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: _appBar(),
      drawer: _menu(),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 0.0),
        child: Container(
          color: uBackground,
          child: getCalendarBody(),
        ),
      ),
      floatingActionButton: _buildNavigation(),
    );
  }
}

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
}
