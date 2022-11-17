import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Theme/themes.dart';
import '../../../main.dart';
import '../popuptask_func.dart';
import '../../functions/tasks_page_func.dart';

var formatterMonth = DateFormat('MM');
var formatterYear = DateFormat('yyyy');
var formatterWeekDay = DateFormat('EEEE');
var formatterDay = DateFormat('d');
var formatterYearMonthDay = DateFormat('yyyy-MM-dd');
var formatterHourMinute = DateFormat('Hm');
var isAllDay = false;

Widget allDaySwitch() {
  return Row(
    children: [
      Padding(
          padding: EdgeInsets.only(left: 7.0),
          child: Text(allDayDesc, style: TextStyle(fontSize: 15))),
      Spacer(),
      Switch(
        value: isAllDay,
        onChanged: (value) {
          isAllDay = !isAllDay; //revert state
          setStateNeeded[0] = true;
        },
        //activeColor: buttonColor,
      ),
    ],
  );
}

Widget startDate(context, setStateId) {
  return Row(
    children: [
      TextButton(
        onPressed: () {
          datePicker(context, 1, setStateId);
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
            timePicker(context, 2, setStateId);
          },
          child: Text(
            '${formatterHourMinute.format(selDateStart)}',
            style: TextStyle(fontSize: 20),
          ),
        ),
        visible: !isAllDay, //if All-Day option is opted in, don't show time
      ),
    ],
  );
}

Widget endDate(context, setStateId) {
  return Row(
    children: [
      TextButton(
        onPressed: () {
          datePicker(context, 3, setStateId);
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
            timePicker(context, 4, setStateId);
          },
          child: Text(
            '${formatterHourMinute.format(selDateEnd)}',
            style: TextStyle(fontSize: 20),
          ),
        ),
        visible: !isAllDay, //if All-Day option is opted in, don't show time
      ),
    ],
  );
}

Widget? datePicker(context, int id, int setStateId) {
  //return native looking date picker
  final ThemeData theme = Theme.of(context);
  if (theme.platform == TargetPlatform.iOS ||
      theme.platform == TargetPlatform.macOS ||
      iosTest == true) {
    return cupertinoDatePicker(context, id);
  } else {
    return FutureBuilder(
      future: materialDatePicker(context, id, setStateId),
      builder: (context, snapshot) {
        return CircularProgressIndicator();
      },
    );
  }
}

materialDatePicker(context, int id, int setStateId) async {
  DateTime? picked = await showDatePicker(
    context: context,
    initialDate: tempDate,
    firstDate: DateTime(1990),
    lastDate: DateTime(2050),
    builder: (context, child) {
      return Theme(
        data: ThemeData.dark(),
        child: child as Widget,
      );
    },
  );
  if (picked != null && picked != tempDate) {
    picked = DateTime(
        picked.year,
        picked.month,
        picked.day,
        id == 1 ? selTimeStart.hour : selTimeEnd.hour,
        id == 1 ? selTimeStart.minute : selTimeEnd.minute);
    print(
        '${picked.year} ${picked.month} ${picked.day} ${id == 1 ? selTimeStart.hour : selTimeEnd.hour} ${id == 1 ? selTimeStart.minute : selTimeEnd.minute}');
    assignToDateTime(id, picked);
    setStateNeeded[setStateId] = true;
  }
}

cupertinoDatePicker(context, int id) {
  showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: MediaQuery.of(context).copyWith().size.height / 2,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.dateAndTime,
            onDateTimeChanged: (picked) {
              if (picked != tempDate) {
                assignToDateTime(id.isEven ? id - 1 : id, picked);
                setStateNeeded[0] = true;
              }
            },
            initialDateTime: tempDate,
            minimumYear: 0,
            maximumYear: 2050,
            use24hFormat: true,
          ),
        );
      });
}

Widget? timePicker(context, int id, setStateId) {
  //return native looking time picker
  final ThemeData theme = Theme.of(context);
  if (theme.platform == TargetPlatform.iOS ||
      theme.platform == TargetPlatform.macOS ||
      iosTest == true) {
    return cupertinoDatePicker(context, id);
  } else {
    return FutureBuilder(
      future: materialTimePicker(context, id, setStateId),
      builder: (context, snapshot) {
        return CircularProgressIndicator();
      },
    );
  }
}

materialTimePicker(context, int id, int setStateId) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: tempDate,
    firstDate: DateTime.now(),
    lastDate: DateTime(2050),
  );
  if (picked != null) {
    assignToDateTime(id, picked);
    assignToDateTime(id - 1, picked);
    print('$selTimeStart $selTimeEnd');
    print('$selTimeStart $selTimeEnd');
    setStateNeeded[setStateId] = true;
  }
}
