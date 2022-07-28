import 'package:aufgabenplaner/main.dart';
import 'package:aufgabenplaner/pages/popuptask/popuptask.dart';
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
                                showDialog(
                                    context: orgContext,
                                    builder: (contextSD) =>
                                        NewTaskPopup(indexK));
                              }),
                          SizedBox(
                            height: 60.0 * tasks[indexK].length +
                                (taskCardExpanded[indexK].item1 ? 100 : 0),
                            child: ListView.builder(
                                itemCount: tasks[indexK].length,
                                itemBuilder: (context, indexT) {
                                  return InkWell(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5),
                                        Container(
                                          height:
                                              taskCardExpanded[indexK].item2 ==
                                                      indexT
                                                  ? 130
                                                  : 30, // 30
                                          padding: EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(7)),
                                            color: Colors.white,
                                          ),
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      tasks[indexK][indexT]
                                                          .title,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 14,
                                                    height: 14,
                                                    decoration: BoxDecoration(
                                                      color: tasks[indexK]
                                                              [indexT]
                                                          .recColor,
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  SizedBox(width: 5),
                                                  InkWell(
                                                    child: Icon(
                                                        CupertinoIcons
                                                            .trash_fill,
                                                        size: 14),
                                                    onTap: () {
                                                      tasks[indexK]
                                                          .removeAt(indexT);
                                                      setStateNeeded[4] = true;
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Visibility(
                                                visible:
                                                    taskCardExpanded[indexK]
                                                            .item2 ==
                                                        indexT,
                                                child: Divider(
                                                    height: 4, endIndent: 40),
                                              ),
                                              Visibility(
                                                visible:
                                                    taskCardExpanded[indexK]
                                                            .item2 ==
                                                        indexT,
                                                child: SizedBox(
                                                  height: 100,
                                                  child: ListView(
                                                    children: [
                                                      Text(
                                                        'notes',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10.0),
                                                      ),
                                                      SizedBox(height: 1),
                                                      Text(
                                                        tasks[indexK][indexT]
                                                            .notes,
                                                      ),
                                                      Divider(
                                                          height: 4,
                                                          endIndent: 10),
                                                      Text(
                                                        'project',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10.0),
                                                      ),
                                                      SizedBox(height: 1),
                                                      Container(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 4,
                                                                top: 2,
                                                                bottom: 2),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors
                                                              .purple[200],
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                        ),
                                                        child: Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            tasks[indexK]
                                                                    [indexT]
                                                                .group
                                                                .item1,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                      Divider(
                                                          height: 4,
                                                          endIndent: 10),
                                                      Text(
                                                        'asignee',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 10.0),
                                                      ),
                                                      SizedBox(height: 1),
                                                      SizedBox(
                                                        height: tasks[indexK]
                                                                    [indexT]
                                                                .asignees
                                                                .length *
                                                            20.0,
                                                        child: ListView.builder(
                                                          itemCount:
                                                              tasks[indexK]
                                                                      [indexT]
                                                                  .asignees
                                                                  .length,
                                                          itemBuilder: (context,
                                                              indexA) {
                                                            return Container(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 4,
                                                                      top: 2,
                                                                      bottom:
                                                                          2),
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerLeft,
                                                                child: Text(
                                                                  tasks[indexK][
                                                                          indexT]
                                                                      .asignees[
                                                                          indexA]
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
                                          taskCardExpanded[indexK].item2 !=
                                              indexT) {
                                        taskCardExpanded[indexK].item2 = indexT;
                                      } else if (taskCardExpanded[indexK]
                                              .item1 &&
                                          taskCardExpanded[indexK].item2 ==
                                              indexT) {
                                        taskCardExpanded[indexK].item1 = false;
                                        taskCardExpanded[indexK].item2 = -1;
                                      } else {
                                        taskCardExpanded[indexK].item1 = true;
                                        taskCardExpanded[indexK].item2 = indexT;
                                      }
                                      setStateNeeded[4] = true;
                                    },
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
