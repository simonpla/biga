import 'package:aufgabenplaner/main.dart';
import 'package:aufgabenplaner/pages/functions/tasks_page_func.dart';
import 'package:aufgabenplaner/pages/popuptask/asignee/asignee.dart';
import 'package:aufgabenplaner/pages/popuptask/notes/notes.dart';
import 'package:aufgabenplaner/pages/popuptask/popuptask.dart';
import 'package:aufgabenplaner/pages/popuptask/taskGroup/taskGroup.dart';
import 'package:aufgabenplaner/pages/popuptask/title_color/title_color.dart';
import 'package:aufgabenplaner/pages/tasks/kanban/kanban.dart';
import 'package:flutter/material.dart';
import '../../../Theme/themes.dart';
import '../../../calendar/functions/calendarFunc.dart';
import '../popuptask_func.dart';

var editIndex = -1;

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
        onPressed: () {
          if (curr_title != '' &&
              curr_notes != '' &&
              used_items.isNotEmpty &&
              used_groups.isNotEmpty) {
            showError = false;
            if (pageDesc == 'edit ') {
              tasks[fromId][editIndex] = Task(curr_title, curr_notes, selDateEnd, 1,
                  used_items, used_groups[0], usedTaskColor);
            } else {
              tasks[fromId].add(Task(
                  curr_title,
                  curr_notes,
                  selDateEnd,
                  1,
                  used_items,
                  used_groups[0],
                  usedTaskColor));
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
