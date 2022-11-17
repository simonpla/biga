import 'package:flutter/material.dart';
import 'package:aufgabenplaner/pages/contacts/contactsFunc.dart';
import 'package:aufgabenplaner/pages/tasks/kanban/kanban.dart';
import 'package:intl/intl.dart';
import '../../tasks_page.dart';
import 'columnsTLD/columnsTLD.dart';

class PairTL<T1, T2> {
  T1 item1;
  T2 item2;

  PairTL(this.item1, this.item2);
}

List<List<Task>> usableTimeLineTasks =
    List.generate(tasks.length, (index) => List.empty(growable: true));

List<PairTL<Task, List<int>>> timeLineTasks = [
  PairTL(
      Task('fzugzugu', 'ghghkbgh', DateTime(2022, 12, 10), 'idk', contacts,
          'group', Colors.black),
      [-1, -1]),
];

var calendarSC = ScrollController();

var monthDisplay = List<DateTime>.filled(60, DateTime(1900, 1));

timelineDisplay() {
  return ListView.builder(
    controller: calendarSC,
    scrollDirection: Axis.horizontal,
    itemCount: 60,
    itemBuilder: (context, indexTL) {
      return Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 3, top: 3),
            height: 40,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              border: Border(
                left: BorderSide(color: Colors.grey[100]!, width: 0.2),
                top: BorderSide(color: Colors.grey[100]!, width: 0.4),
                right: BorderSide(color: Colors.grey[100]!, width: 0.2),
                bottom: BorderSide(color: Colors.grey[100]!, width: 0.4),
              ),
            ),
            child: Align(
              alignment: Alignment(-1, -0.3),
              child: Text(DateFormat.yMMM().format(monthDisplay[indexTL]),
                  ),
            ),
          ),
          SizedBox(
            height: timeLineTasks.length * 30.0,
            width: 200,
            child: columnsTLD(indexTL),
          ),
        ],
      );
    },
  );
}
