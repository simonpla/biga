import 'package:aufgabenplaner/main.dart';
import 'package:aufgabenplaner/pages/popuptask/popuptask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../calendar/functions/calendarFunc.dart';

var _kanbanSC = ScrollController();

var taskCards = ['To Do', 'In Progress', 'Done'];

var editName = [false, false, false];

List<List<Task>> tasks =
    List.generate(3, (index) => List.empty(growable: true), growable: true);

Widget kanban(orgContext) {
  return Padding(
    padding: EdgeInsets.only(top: 25.0, bottom: 100.0),
    child: Scrollbar(
      controller: _kanbanSC,
      child: ListView.builder(
        shrinkWrap: true,
        controller: _kanbanSC,
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
                            child: Text(
                              taskCards[indexK],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Visibility(
                            visible: editName[indexK],
                            child: TextField(
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: EdgeInsets.all(8),
                                isDense: true,
                              ),
                              onSubmitted: (value) {
                                taskCards[indexK] = value;
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
                                showDialog(
                                    context: orgContext,
                                    builder: (contextSD) =>
                                        NewTaskPopup(indexK));
                              }),
                          SizedBox(
                            height: 40.0 * tasks[indexK].length,
                            child: ListView.builder(
                                itemCount: tasks[indexK].length,
                                itemBuilder: (context, indexT) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 5),
                                      Container(
                                        height: 30,
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(7)),
                                          color: Colors.white,
                                        ),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            tasks[indexK][indexT].title,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                    ],
                                  );
                                }),
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
