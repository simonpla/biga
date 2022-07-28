import 'dart:async';
import 'package:aufgabenplaner/pages/appBar/appBar.dart';
import 'package:aufgabenplaner/pages/navigationbar/navigation_bar.dart';
import 'package:aufgabenplaner/pages/notes/notesList/notesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  var _beenReleased = true;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 1), (Timer t) {
      if (_beenReleased &&
          (RawKeyboard.instance.keysPressed
                  .containsAll(
                      [LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyZ]) ||
              RawKeyboard.instance.keysPressed.containsAll(
                  [LogicalKeyboardKey.controlRight, LogicalKeyboardKey.keyZ]) ||
              RawKeyboard.instance.keysPressed.containsAll(
                  [LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.keyZ]) ||
              RawKeyboard.instance.keysPressed.containsAll(
                  [LogicalKeyboardKey.metaRight, LogicalKeyboardKey.keyZ]))) {
        if (!notesControllers[selectedNote].isEmpty) {
          notesControllers[selectedNote].undo();
        }
      }
      if (!(RawKeyboard.instance.keysPressed.containsAll(
              [LogicalKeyboardKey.controlLeft, LogicalKeyboardKey.keyZ]) ||
          RawKeyboard.instance.keysPressed.containsAll(
              [LogicalKeyboardKey.controlRight, LogicalKeyboardKey.keyZ]) ||
          RawKeyboard.instance.keysPressed.containsAll(
              [LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.keyZ]) ||
          RawKeyboard.instance.keysPressed.containsAll(
              [LogicalKeyboardKey.metaRight, LogicalKeyboardKey.keyZ]))) {
        _beenReleased = true;
      } else {
        _beenReleased = false;
      }
      checkSetState();
    });
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
          Expanded(
            child: Stack(
              children: [
                Painter(notesControllers[selectedNote]),
                Positioned(
                  right: 5,
                  child: IconButton(
                    icon: Icon(Icons.undo),
                    onPressed: () {
                      if (!notesControllers[selectedNote].isEmpty) {
                        notesControllers[selectedNote].undo();
                      }
                    },
                  ),
                ),
                Positioned(
                  right: 40,
                  child: IconButton(
                    icon: Icon(Icons.text_fields_rounded),
                    onPressed: () => null,
                  ),
                ),
              ],
            ),
          ),
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
