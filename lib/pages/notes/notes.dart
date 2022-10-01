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

List<Pair<TextEditingController, List<double>>> textFields =
    List.generate(0, (index) => Pair(TextEditingController(), [0, 0]));

var counterLines = List.generate(textFields.length, (index) => 2);

var textAdditionMode = false;

class Notes extends StatefulWidget {
  Notes({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NotesState();
}

double map(
    double x, double in_min, double in_max, double out_min, double out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

List<Widget> _stackTextBuilder() {
  List<Widget> _stackTextItems = [];

  for (int i = 0; i < textFields.length; i++) {

    _stackTextItems.add(
      Positioned(
        left: textFields[i].item2[0],
        top: textFields[i].item2[1],
        child: SizedBox(
          height: counterLines[i] * 30.0,
          width: 150,
          child: TextField(
            controller: textFields[i].item1,
            maxLines: null,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, color: Colors.transparent)),
              focusedBorder: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 7),
            ),
            style: TextStyle(
              fontSize: 14,
            ),
            onChanged: (value) {
              counterLines[i] =
                  '\n'.allMatches(textFields[i].item1.text).length + 1;
              setStateNeeded[5] = true;
            },
          ),
        ),
      ),
    );
  }
  return _stackTextItems;
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
            child: Listener(
              onPointerUp: (PointerEvent details) {
                setState(() {
                  if (textAdditionMode) {
                    textFields.add(Pair(TextEditingController(),
                        [details.position.dx, details.position.dy]));
                    counterLines.add(2);
                    print([details.position.dx, details.position.dy]);
                  }
                });
              },
              child: Stack(
                children: [
                  Painter(notesControllers[selectedNote]),
                  IgnorePointer(
                    ignoring: !textAdditionMode,
                    child: Stack(
                      children: _stackTextBuilder(),
                    ),
                  ),
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
                    top: 7,
                    right: 47,
                    child: InkWell(
                      child: Icon(
                        Icons.text_fields_rounded,
                        color: textAdditionMode ? Colors.blue : Colors.black,
                      ),
                      onTap: () {
                        setState(() {
                          textAdditionMode = !textAdditionMode;
                        });
                      },
                    ),
                  ),
                ],
              ),
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
