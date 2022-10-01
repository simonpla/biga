import 'dart:async';

import 'package:aufgabenplaner/pages/tasks/timeline/timelineDisplay/timelineDisplay.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../../appBar/appBar.dart';
import '../../menuDrawer/menuDrawer.dart';
import '../../navigationbar/navigation_bar.dart';
import 'infoRow/infoRow.dart';
import 'navigationArrows/navigationArrows.dart';


var isNewExpanded = false;

class Timeline extends StatefulWidget {
  Timeline({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TimelineState();
}

class TimelineState extends State<Timeline> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(Duration(milliseconds: 1), (Timer t) => checkSetState());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  void assignDates() {
    var dateNow = DateTime.now();
    for (int i = 0; i < 60; i++) {
      if (i < 10) {
        monthDisplay[i] =
            DateTime(dateNow.year, dateNow.month - 10 + i, dateNow.day);
      } else {
        monthDisplay[i] =
            DateTime(dateNow.year, dateNow.month + i - 10, dateNow.day);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    animateToIndex(showIndex);
    assignDates();

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context),
      drawer: menuDrawer(context),
      body: Container(
        padding: EdgeInsets.only(left: 30, top: 15, right: 30),
        height: timeLineTasks.length * 30.0 + 80.0 + (isNewExpanded ? 200 : 0),
        child: Row(
          children: [
            infoRow(),
            Expanded(
              child: Stack(
                children: [
                  timelineDisplay(),
                  Positioned(top: 0, left: 0, child: navigationArrows(0)),
                  Positioned(top: 0, right: 0, child: navigationArrows(1)),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: buildLowerNavigation(context, scaffoldKey, -1),
    );
  }

  checkSetState() {
    if (setStateNeeded[6] == true) {
      setState(() {
        setStateNeeded[6] = false;
      });
    }
  }
}
