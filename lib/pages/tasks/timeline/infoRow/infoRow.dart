import 'package:aufgabenplaner/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../timeline.dart';
import '../timelineDisplay/timelineDisplay.dart';

var hoverLeft = List<bool>.of([false]);
var hoverRight = List<bool>.of([false]);

infoRow() {
  return SizedBox(
      width: 200,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 3, top: 3),
            height: 40,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              border: Border(
                left: BorderSide(color: Colors.grey[700]!, width: 0.2),
                top: BorderSide(color: Colors.grey[700]!, width: 0.4),
                right: BorderSide(color: Colors.grey[700]!, width: 0.2),
                bottom: BorderSide(color: Colors.grey[700]!, width: 0.4),
              ),
            ),
            child: Align(
              alignment: Alignment(-1, -0.3),
              child: Text('name', style: TextStyle(color: Colors.grey[700])),
            ),
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              height: timeLineTasks.length * 30.0,
              width: 200,
              child: ListView.builder(
                itemCount: timeLineTasks.length,
                itemBuilder: (context, indexT) {
                  return Container(
                    height: 30,
                    width: 200,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 3),
                    decoration: BoxDecoration(
                      color: indexT.isOdd ? Colors.grey[100] : Colors.white,
                      border: Border(
                        left: BorderSide(color: Colors.grey[700]!, width: 0.2),
                        right: BorderSide(color: Colors.grey[700]!, width: 0.2),
                        bottom: BorderSide(
                            color: Colors.grey[700]!,
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
                            color: Colors.black,
                            size: 16,
                          ),
                          onTap: () {
                            usableTimeLineTasks[timeLineTasks[indexT].item2[0]]
                                .add(timeLineTasks[indexT].item1);
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
                child: InkWell(
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Icon(CupertinoIcons.add, size: 20),
                  onTap: () {
                    isNewExpanded = true;
                    setStateNeeded[6] = true;
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
                            onTap: () {
                              timeLineTasks.add(PairTL(
                                  usableTimeLineTasks[indexTL][indexTL2],
                                  [indexTL, indexTL2]));
                              isNewExpanded = false;
                              usableTimeLineTasks[indexTL].removeAt(indexTL2);
                              hoverLeft.add(false);
                              hoverRight.add(false);
                              setStateNeeded[6] = true;
                            },
                          );
                        },
                      ),
                    );
                  }),
            ),
          ),
        ],
      ));
}
