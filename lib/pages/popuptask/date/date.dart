import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Theme/themes.dart';
import '../../../calendar/functions/calendarFunc.dart';
import '../../../main.dart';
import '../popuptask_func.dart';
import '../../functions/tasks_page_func.dart';

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
        activeColor: buttonColor,
      ),
    ],
  );
}

Widget startDate(context) {
  return Row(
    children: [
      TextButton(
        onPressed: () {
          datePicker(context, 1);
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
            timePicker(context, 2);
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

Widget endDate(context) {
  return Row(
    children: [
      TextButton(
        onPressed: () {
          datePicker(context, 3);
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
            timePicker(context, 4);
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

Widget? datePicker(context, int id) {
  //return native looking date picker
  final ThemeData theme = Theme.of(context);
  if (theme.platform == TargetPlatform.iOS ||
      theme.platform == TargetPlatform.macOS ||
      iosTest == true) {
    return cupertinoDatePicker(context, id);
  } else {
    return FutureBuilder(
      future: materialDatePicker(context, id),
      builder: (context, snapshot) {
        return CircularProgressIndicator();
      },
    );
  }
}

materialDatePicker(context, int id) async {
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
    picked = DateTime(
        picked.year,
        picked.month,
        picked.day,
        id == 1 ? selTimeStart.hour : selTimeEnd.hour,
        id == 1 ? selTimeStart.minute : selTimeEnd.minute);
    print(
        '${picked.year} ${picked.month} ${picked.day} ${id == 1 ? selTimeStart.hour : selTimeEnd.hour} ${id == 1 ? selTimeStart.minute : selTimeEnd.minute}');
    assignToDateTime(id, picked);
    setStateNeeded[0] = true;
  }
}

cupertinoDatePicker(context, int id) {
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

Widget? timePicker(context, int id) {
  //return native looking time picker
  final ThemeData theme = Theme.of(context);
  if (theme.platform == TargetPlatform.iOS ||
      theme.platform == TargetPlatform.macOS ||
      iosTest == true) {
    return cupertinoDatePicker(context, id);
  } else {
    return FutureBuilder(
      future: materialTimePicker(context, id),
      builder: (context, snapshot) {
        return CircularProgressIndicator();
      },
    );
  }
}

materialTimePicker(context, int id) async {
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
    setStateNeeded[0] = true;
  }
}
