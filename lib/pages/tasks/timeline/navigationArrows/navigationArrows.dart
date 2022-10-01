import 'package:aufgabenplaner/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../timeline.dart';
import '../timelineDisplay/timelineDisplay.dart';

var containerColor = [
  Colors.grey[200]?.withOpacity(0.1),
  Colors.grey[200]?.withOpacity(0.1)
];
var arrowColor = [
  Colors.grey[600]?.withOpacity(0.2),
  Colors.grey[600]?.withOpacity(0.2)
];

var showIndex = 10;

void animateToIndex(index) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (calendarSC.hasClients) {
      calendarSC.animateTo(index * 200.0,
          duration: Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
    }
  });
}

navigationArrows(index) {
  return InkWell(
    child: Container(
      height: timeLineTasks.length * 30.0 + 40.0,
      width: 20,
      color: containerColor[index],
      child: Center(
        child: Icon(
            index == 0
                ? CupertinoIcons.left_chevron
                : CupertinoIcons.right_chevron,
            color: arrowColor[index]),
      ),
    ),
    onHover: (isHover) {
      if (isHover) {
        containerColor[index] = Colors.grey[300]?.withOpacity(0.8);
        arrowColor[index] = Colors.grey[800]?.withOpacity(1.0);
      } else {
        containerColor[index] = Colors.grey[200]?.withOpacity(0.1);
        arrowColor[index] = Colors.grey[600]?.withOpacity(0.2);
      }
      setStateNeeded[6] = true;
    },
    onTap: () {
      if (index == 0) {
        if (showIndex > 0) {
          animateToIndex(showIndex - 1);
          showIndex -= 1;
        }
      } else {
        if (showIndex < 59) {
          animateToIndex(showIndex + 1);
          showIndex += 1;
        }
      }
      setStateNeeded[6] = true;
    },
  );
}
