import 'package:aufgabenplaner/main.dart';
import 'package:aufgabenplaner/pages/contacts/newContactPopup/newContactPopup.dart';
import 'package:aufgabenplaner/pages/functions/tasks_page_func.dart';
import 'package:aufgabenplaner/pages/popuptask/asignee/asignee.dart';
import 'package:aufgabenplaner/pages/popuptask/date/date.dart';
import 'package:aufgabenplaner/pages/popuptask/notes/notes.dart';
import 'package:aufgabenplaner/pages/popuptask/popuptask.dart';
import 'package:aufgabenplaner/pages/popuptask/popuptask_func.dart';
import 'package:aufgabenplaner/pages/popuptask/taskGroup/taskGroup.dart';
import 'package:aufgabenplaner/pages/popuptask/title_color/title_color.dart';
import 'package:aufgabenplaner/pages/popuptask/topBar/topBar.dart';
import 'package:aufgabenplaner/pages/tasks/kanban/taskDisplay/taskDisplay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../calendar/functions/calendarFunc.dart';

class PairK<T1, T2> {
  T1 item1;
  T2 item2;

  PairK(this.item1, this.item2);
}

var kanbanSC = ScrollController();

List<PairK<String, FocusNode>> taskCards = [
  PairK('To Do', FocusNode()),
  PairK('In Progress', FocusNode()),
  PairK('Done', FocusNode()),
];

var editName = [false, false, false];

var taskCardExpanded = [PairK(false, -1), PairK(false, -1), PairK(false, -1)];

List<List<Task>> tasks =
    List.generate(3, (index) => List.empty(growable: true), growable: true);

Widget kanban(orgContext) {
  return Padding(
    padding: EdgeInsets.only(top: 25.0, bottom: 100.0),
    child: Scrollbar(
      controller: kanbanSC,
      child: ListView.builder(
        shrinkWrap: true,
        controller: kanbanSC,
        scrollDirection: Axis.horizontal,
        itemCount: taskCards.length,
        itemBuilder: (context, indexK) {
          return SizedBox(
            width: 250,
            child: Row(
              children: [
                Spacer(),
                Column(
                  children: [
                    Container(
                      width: 200,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xfff2d3cb),
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: !editName[indexK],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    taskCards[indexK].item1,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                  ),
                                ),
                                SizedBox(width: 10),
                                InkWell(
                                  child: Icon(
                                    CupertinoIcons.trash_fill,
                                    color: Colors.black,
                                    size: 19,
                                  ),
                                  onTap: () {
                                    taskCards.removeAt(indexK);
                                    editName.removeAt(indexK);
                                    tasks.removeAt(indexK);
                                    taskCardExpanded.removeAt(indexK);
                                    setStateNeeded[4] = true;
                                  },
                                )
                              ],
                            ),
                          ),
                          Visibility(
                            visible: editName[indexK],
                            child: TextField(
                              focusNode: taskCards[indexK].item2,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(8),
                                isDense: true,
                              ),
                              onSubmitted: (value) {
                                taskCards[indexK].item1 = value;
                                editName[indexK] = false;
                                setStateNeeded[4] = true;
                              },
                            ),
                          ),
                          InkWell(
                              child: Icon(CupertinoIcons.add, size: 20.0),
                              radius: 13,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                pageDesc = 'create new ';
                                showDialog(
                                    context: orgContext,
                                    builder: (contextSD) {
                                      titleController.text = '';
                                      notesController.text = '';
                                      selDateEnd = DateTime.now();
                                      filtered_items.addAll(used_items);
                                      used_items = [];
                                      filtered_groups.addAll(used_groups);
                                      used_groups = [];
                                      usedTaskColor = Colors.orange;
                                      return NewTaskPopup(indexK);
                                    });
                              }),
                          SizedBox(
                            height: 60.0 * tasks[indexK].length +
                                (taskCardExpanded[indexK].item1 ? 130 : 0),
                            child: taskDisplay(orgContext, indexK),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
                Spacer(),
              ],
            ),
          );
        },
      ),
    ),
  );
}
