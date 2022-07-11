import 'dart:async';

import 'package:aufgabenplaner/pages/appBar/appBar.dart';
import 'package:aufgabenplaner/pages/navigationbar/navigation_bar.dart';
import 'package:aufgabenplaner/pages/notes/notesList/notesList.dart';
import 'package:flutter/material.dart';
import 'package:painter/painter.dart';
import '../../main.dart';
import '../tasks/drawerMenu/drawerMenu.dart';

List<PainterController> notesControllers = List.generate(notes.length, (index) {
  PainterController controller = new PainterController();
  controller.thickness = 3.0;
  controller.backgroundColor = Colors.white;
  return controller;
}, growable: true);

class Notes extends StatefulWidget {
  Notes({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NotesState();
}

class NotesState extends State<Notes> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
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

  @override
  Widget build(context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context),
      drawer: drawerMenu(context),
      body: Row(
        children: [
          notesList(context),
          Expanded(child: Painter(notesControllers[selectedNote])),
        ],
      ),
      floatingActionButton: buildLowerNavigation(context, scaffoldKey, 3),
    );
  }

  checkSetState() {
    if (setStateNeeded[5] == true) {
      setState(() {
        setStateNeeded[5] = false;
      });
    }
  }
}
