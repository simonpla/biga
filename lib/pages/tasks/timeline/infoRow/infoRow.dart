import 'package:aufgabenplaner/main.dart';
import 'package:aufgabenplaner/pages/popuptask/date/date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../../database/database.dart';
import '../timeline.dart';
import '../timelineDisplay/timelineDisplay.dart';

var hoverLeft = List<bool>.of([false]);
var hoverRight = List<bool>.of([false]);

infoRow(context) {
  return SizedBox(
    width: MediaQuery.of(context).size.width > 500 ? 200 : 120,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 3, top: 3),
          height: 40,
          width: MediaQuery.of(context).size.width > 500 ? 200 : 120,
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
            child: Text('name'),
          ),
        ),
        Expanded(
          flex: 3,
          child: SizedBox(
            height: timeLineTasks.length * 30.0,
            width: MediaQuery.of(context).size.width > 500 ? 200 : 120,
            child: ListView.builder(
              itemCount: timeLineTasks.length,
              itemBuilder: (context, indexT) {
                return Container(
                  height: 30,
                  width: 200,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 3),
                  decoration: BoxDecoration(
                    color: indexT.isOdd ? Colors.grey[800] : Colors.transparent,
                    border: Border(
                      left: BorderSide(color: Colors.grey[100]!, width: 0.2),
                      right: BorderSide(color: Colors.grey[100]!, width: 0.2),
                      bottom: BorderSide(
                          color: Colors.grey[100]!,
                          width:
                              indexT == timeLineTasks.length - 1 ? 0.4 : 0.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(timeLineTasks[indexT].item1.title),
                      Spacer(),
                      InkWell(
                        child: Icon(
                          CupertinoIcons.trash_fill,
                          color: Colors.white,
                          size: 16,
                        ),
                        onTap: () async {
                          usableTimeLineTasks[timeLineTasks[indexT].item2[0]]
                              .add(timeLineTasks[indexT].item1);
                          await connection.transaction((ctx) async {
                            var id =
                                '${timeLineTasks[indexT].item2[0]},${timeLineTasks[indexT].item2[1]}';
                            await ctx.query(
                                "DELETE FROM timelineTasks WHERE id=@a",
                                substitutionValues: {
                                  "a": id,
                                });
                          });
                          timeLineTasks.removeAt(indexT);
                          setStateNeeded[6] = true;
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        Visibility(
          visible: !isNewExpanded,
          child: SizedBox(
            height: 24,
            child: Container(
              padding: EdgeInsets.only(left: 20, top: 5),
              child: IconButton(
                //hoverColor: Colors.transparent,
                //highlightColor: Colors.transparent,
                icon: Icon(CupertinoIcons.add, size: 20),
                onPressed: () {
                  //isNewExpanded = true;
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    showDialog(
                        context: context,
                        builder: (context) => datePicker(context, 1, 6)!);
                  });
                  //setStateNeeded[6] = true;
                },
              ),
            ),
          ),
        ),
        Visibility(
          visible: isNewExpanded,
          child: SizedBox(
            height: 24,
            child: Container(
              padding: EdgeInsets.only(left: 20, top: 5),
              child: InkWell(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                child: Icon(CupertinoIcons.clear, size: 20),
                onTap: () {
                  isNewExpanded = false;
                  setStateNeeded[6] = true;
                },
              ),
            ),
          ),
        ),
        Visibility(
          visible: isNewExpanded,
          child: Container(
            height: 200,
            child: ListView.builder(
                itemCount: usableTimeLineTasks.length,
                itemBuilder: (context, indexTL) {
                  return Container(
                    height: usableTimeLineTasks[indexTL].length * 17.0,
                    child: ListView.builder(
                      itemCount: usableTimeLineTasks[indexTL].length,
                      itemBuilder: (context2, indexTL2) {
                        return InkWell(
                          child: Text(
                              usableTimeLineTasks[indexTL][indexTL2].title),
                          onTap: () async {
                            timeLineTasks.add(PairTL(
                                usableTimeLineTasks[indexTL][indexTL2],
                                [indexTL, indexTL2]));
                            isNewExpanded = false;
                            usableTimeLineTasks[indexTL].removeAt(indexTL2);
                            hoverLeft.add(false);
                            hoverRight.add(false);
                            setStateNeeded[6] = true;
                            await connection.transaction((ctx) async {
                              var id = '$indexTL,$indexTL2';
                              await ctx.query(
                                  "INSERT INTO timelineTasks VALUES (@a)",
                                  substitutionValues: {
                                    "a": id,
                                  });
                            });
                          },
                        );
                      },
                    ),
                  );
                }),
          ),
        ),
      ],
    ),
  );
}
