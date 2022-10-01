import 'package:aufgabenplaner/main.dart';
import 'package:aufgabenplaner/pages/functions/tasks_page_func.dart';
import 'package:aufgabenplaner/pages/popuptask/asignee/asignee.dart';
import 'package:aufgabenplaner/pages/popuptask/notes/notes.dart';
import 'package:aufgabenplaner/pages/popuptask/popuptask.dart';
import 'package:aufgabenplaner/pages/popuptask/taskGroup/taskGroup.dart';
import 'package:aufgabenplaner/pages/popuptask/title_color/title_color.dart';
import 'package:aufgabenplaner/pages/tasks/kanban/kanban.dart';
import 'package:aufgabenplaner/pages/tasks/timeline/timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Theme/themes.dart';
import '../../../calendar/functions/calendarFunc.dart';
import '../../../database/database.dart';
import '../../tasks/timeline/timelineDisplay/timelineDisplay.dart';
import '../popuptask_func.dart';

var editIndex = -1;

_packageContacts() {
  String contactsPackaged = '';
  used_items.forEach((cc) {
    contactsPackaged = contactsPackaged +
        cc.name +
        ',' +
        cc.tel +
        ',' +
        cc.mail +
        ',' +
        cc.company +
        ',' +
        cc.team +
        ';';
  });
  return contactsPackaged;
}

Widget topBar(context, pageDescription, fromId) {
  return Row(
    children: [
      Spacer(),
      IconButton(
          onPressed: () => Navigator.pop(context),
          icon: closeIcon,
          iconSize: 23),
      Spacer(flex: 80),
      Text(pageDescription,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      Spacer(flex: 80),
      ElevatedButton(
        onPressed: () async {
          if (curr_title != '' &&
              curr_notes != '' &&
              used_items.isNotEmpty &&
              used_groups.isNotEmpty) {
            showError = false;
            if (pageDesc == 'edit ') {
              for (int i = 0; i < timeLineTasks.length; i++) {
                if (timeLineTasks[i].item1 == tasks[fromId][editIndex]) {
                  timeLineTasks[i] = PairTL(
                      Task(curr_title, curr_notes, selDateEnd, 1, used_items,
                          used_groups[0], usedTaskColor),
                      [fromId, editIndex]);
                  print('found right one at $i');
                  await connection.transaction((connection) async {
                    await connection.query(
                        "INSERT INTO tasks VALUES (@a, @b, @c, @d, @e, @f, @g, @h)",
                        substitutionValues: {
                          "a": '$fromId,${tasks[fromId].length - 1}',
                          "b": curr_title,
                          "c": DateFormat('yyyy-MM-dd').format(selDateEnd),
                          "d": 1,
                          "e": curr_notes,
                          "f": _packageContacts(),
                          "g": used_groups[0].item1,
                          "h": usedTaskColor.toString(),
                        });
                  });
                }
              }
              tasks[fromId][editIndex] = Task(curr_title, curr_notes,
                  selDateEnd, 1, used_items, used_groups[0], usedTaskColor);
              await connection.transaction((connection) async {
                await connection.query(
                    "INSERT INTO tasks VALUES (@a, @b, @c, @d, @e, @f, @g, @h)",
                    substitutionValues: {
                      "a":
                          '$fromId,${tasks[fromId].length - 1}',
                      "b": curr_title,
                      "c": DateFormat('yyyy-MM-dd').format(selDateEnd),
                      "d": 1,
                      "e": curr_notes,
                      "f": _packageContacts(),
                      "g": used_groups[0].item1,
                      "h": usedTaskColor.toString(),
                    });
              });
            } else {
              tasks[fromId].add(Task(curr_title, curr_notes, selDateEnd, 1,
                  used_items, used_groups[0], usedTaskColor));
              usableTimeLineTasks[fromId].add(tasks[fromId].last);
              await connection.transaction((connection) async {
                await connection.query(
                    "INSERT INTO tasks VALUES (@a, @b, @c, @d, @e, @f, @g, @h)",
                    substitutionValues: {
                      "a": '$fromId,${tasks[fromId].length - 1}',
                      "b": curr_title,
                      "c": DateFormat('yyyy-MM-dd').format(selDateEnd),
                      "d": 1,
                      "e": curr_notes,
                      "f": _packageContacts(),
                      "g": used_groups[0].item1,
                      "h": usedTaskColor.value.toString(),
                    });
              });
            }
            curr_title = '';
            curr_notes = '';
            setStateNeeded[0] = true;
            Navigator.pop(context);
          } else {
            showError = true;
          }
          Future.delayed(Duration(milliseconds: 10), () {
            setStateNeeded[0] = true;
            setStateNeeded[4] = true;
          });
        },
        child: Text(saveDesc),
      ),
      Spacer(flex: 2),
    ],
  );
}
