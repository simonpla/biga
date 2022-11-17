import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../database/database.dart';
import '../../../../main.dart';
import '../../../functions/tasks_page_func.dart';
import '../../../popuptask/asignee/asignee.dart';
import '../../../popuptask/notes/notes.dart';
import '../../../popuptask/popuptask.dart';
import '../../../popuptask/popuptask_func.dart';
import '../../../popuptask/taskGroup/taskGroup.dart';
import '../../../popuptask/title_color/title_color.dart';
import '../../../popuptask/topBar/topBar.dart';
import '../kanban.dart';

Widget taskDisplay(orgContext, indexK) {
  return ListView.builder(
      itemCount: tasks[indexK].length,
      itemBuilder: (context, indexT) {
        return InkWell(
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Container(
                height:
                    taskCardExpanded[indexK].item2 == indexT ? 160 : 30, // 30
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(7)),
                  color: Colors.grey[900],
                ),
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            tasks[indexK][indexT].title,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: tasks[indexK][indexT].recColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          child: Icon(CupertinoIcons.pen, size: 16),
                          onTap: () {
                            pageDesc = 'edit ';
                            showDialog(
                                context: orgContext,
                                builder: (contextEdit) {
                                  editIndex = indexT;
                                  titleController.text =
                                      tasks[indexK][indexT].title;
                                  curr_title = tasks[indexK][indexT].title;
                                  notesController.text =
                                      tasks[indexK][indexT].notes;
                                  curr_notes = tasks[indexK][indexT].notes;
                                  selDateEnd = tasks[indexK][indexT].end;
                                  used_items = tasks[indexK][indexT].asignees;
                                  used_groups = [tasks[indexK][indexT].group];
                                  usedTaskColor =
                                      tasks[indexK][indexT].recColor;
                                  return NewTaskPopup(indexK);
                                });
                            setStateNeeded[4] = true;
                          },
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          child: Icon(CupertinoIcons.trash_fill, size: 14),
                          onTap: () async {
                            tasks[indexK].removeAt(indexT);
                            await connection.transaction((ctx) async {
                              var id = '$indexK,$indexT';
                              await ctx.query("DELETE FROM tasks WHERE id=@a",
                                  substitutionValues: {
                                    "a": id,
                                  });
                            });
                            setStateNeeded[4] = true;
                          },
                        ),
                      ],
                    ),
                    Visibility(
                      visible: taskCardExpanded[indexK].item2 == indexT,
                      child: Divider(height: 4, endIndent: 40),
                    ),
                    Visibility(
                      visible: taskCardExpanded[indexK].item2 == indexT,
                      child: SizedBox(
                        height: 130,
                        child: ListView(
                          children: [
                            Text(
                              'notes',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10.0),
                            ),
                            SizedBox(height: 1.5),
                            Text(
                              tasks[indexK][indexT].notes,
                            ),
                            Divider(height: 4, endIndent: 10),
                            Text(
                              'project',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10.0),
                            ),
                            SizedBox(height: 1.5),
                            Container(
                              padding:
                                  EdgeInsets.only(left: 4, top: 2, bottom: 2),
                              decoration: BoxDecoration(
                                color: Colors.purple[200],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  tasks[indexK][indexT].group.item1,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Divider(height: 4, endIndent: 10),
                            Text(
                              tasks[indexK][indexT].asignees.length > 1
                                  ? 'asignees'
                                  : 'asignee',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 10.0),
                            ),
                            SizedBox(height: 1.5),
                            SizedBox(
                              height:
                                  tasks[indexK][indexT].asignees.length * 20.0,
                              child: ListView.builder(
                                itemCount:
                                    tasks[indexK][indexT].asignees.length,
                                itemBuilder: (context, indexA) {
                                  return Container(
                                    padding: EdgeInsets.only(
                                        left: 4, top: 2, bottom: 2),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        tasks[indexK][indexT]
                                            .asignees[indexA]
                                            .name,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
            ],
          ),
          onTap: () {
            if (taskCardExpanded[indexK].item1 &&
                taskCardExpanded[indexK].item2 != indexT) {
              taskCardExpanded[indexK].item2 = indexT;
            } else if (taskCardExpanded[indexK].item1 &&
                taskCardExpanded[indexK].item2 == indexT) {
              taskCardExpanded[indexK].item1 = false;
              taskCardExpanded[indexK].item2 = -1;
            } else {
              taskCardExpanded[indexK].item1 = true;
              taskCardExpanded[indexK].item2 = indexT;
            }
            setStateNeeded[4] = true;
          },
        );
      });
}
