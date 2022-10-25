import 'dart:async';
import 'package:aufgabenplaner/pages/appBar/appBar.dart';
import 'package:aufgabenplaner/pages/navigationbar/navigation_bar.dart';
import 'package:aufgabenplaner/pages/notes/notesList/notesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:painter/painter.dart';
import '../../database/database.dart';
import '../../main.dart';
import '../tasks/drawerMenu/drawerMenu.dart';

List<PairNL<PainterController, List<ScrollController>>>
    notesControllers = // controls painter and x,y scrolling controller
    List.generate(notes.length, (index) {
  PainterController controller = new PainterController();
  controller.thickness = 3.0;
  controller.backgroundColor = Colors.white;
  return PairNL(controller, [ScrollController(), ScrollController()]);
}, growable: true);

List<List<PairNL<PairNL<TextEditingController, FocusNode>, List<double>>>>
    textFields = List.generate(
        notesControllers.length,
        (index) => List.generate(
            0,
            (index) =>
                PairNL(PairNL(TextEditingController(), FocusNode()), [0, 0])));

List<List<int>> counterLines = List.empty(growable: true);

List<ScrollController> scroll = [];

List<List<PairNL<String, List<double>>>> hasChanged = List.empty(growable: true);

class Notes extends StatefulWidget {
  Notes({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NotesState();
}

double map(
    double x, double in_min, double in_max, double out_min, double out_max) {
  return (x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min;
}

List<Widget> _stackTextBuilder(orgContext) {
  List<Widget> _stackTextItems = [];

  for (int i = 0; i < textFields[selectedNote].length; i++) {
    _stackTextItems.add(
      Positioned(
        left: textFields[selectedNote][i].item2[0] -
            (MediaQuery.of(orgContext).size.width / 4.5 > 300
                ? 250
                : MediaQuery.of(orgContext).size.width / 4.5),
        top: textFields[selectedNote][i].item2[1] - 50,
        child: SizedBox(
          height: counterLines[selectedNote][i] * 30.0,
          width: 150,
          child: TextField(
            controller: textFields[selectedNote][i].item1.item1,
            focusNode: textFields[selectedNote][i].item1.item2,
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
              counterLines[selectedNote][i] = '\n'
                      .allMatches(textFields[selectedNote][i].item1.item1.text)
                      .length +
                  1;
              var alreadyChanged = -1;
              for (int j = 0; j < hasChanged[selectedNote].length; j++) {
                if (hasChanged[selectedNote][j].item2 ==
                    textFields[selectedNote][i].item2) {
                  alreadyChanged = j;
                }
              }
              if (alreadyChanged == -1) {
                hasChanged[selectedNote]
                    .add(PairNL(value, textFields[selectedNote][i].item2));
              } else {
                hasChanged[selectedNote][alreadyChanged].item1 = value;
              }
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
        if (!notesControllers[selectedNote].item1.isEmpty) {
          notesControllers[selectedNote].item1.undo();
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
    Timer.periodic(Duration(minutes: 1), (timer) async {
      await connection.transaction((ctx) async {
        for (int i = 0; i < hasChanged.length; i++) {
          for (int j = 0; j < hasChanged[i].length; j++) {

            await ctx.query("DELETE FROM notesText WHERE pos=@a",
                substitutionValues: {
                  "a":
                      '${hasChanged[i][j].item2[0]},${hasChanged[i][j].item2[1]}',
                });

            await ctx.query("INSERT INTO notesText VALUES (@a, @b, @c)",
                substitutionValues: {
                  "a": i,
                  "b": hasChanged[i][j].item1,
                  "c":
                      '${hasChanged[i][j].item2[0]},${hasChanged[i][j].item2[1]}',
                });

            hasChanged[i].clear();
          }
        }
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(context) {
    for (var b in notesControllers[selectedNote].item1.pathHistory.paths) {
      print(b.value);
      print(b.key);
      print(b.key);
    }
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context),
      drawer: drawerMenu(context),
      body: notesControllers.length > 0
          ? Row(
              children: [
                notesList(context),
                Expanded(
                  child: Listener(
                    onPointerUp: (PointerEvent details) {
                      setState(() {
                        if (RawKeyboard.instance.keysPressed
                            .contains(LogicalKeyboardKey.shiftLeft)) {
                          textFields[selectedNote].add(PairNL(
                              PairNL(TextEditingController(), FocusNode()), [
                            details.position.dx +
                                notesControllers[selectedNote].item2[1].offset,
                            details.position.dy +
                                notesControllers[selectedNote].item2[0].offset
                          ]));
                          counterLines[selectedNote].add(1);
                          textFields[selectedNote]
                              .last
                              .item1
                              .item2
                              .requestFocus();
                        }
                      });
                    },
                    child: Stack(
                      children: [
                        Scrollbar(
                          controller: notesControllers[selectedNote].item2[1],
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            controller: notesControllers[selectedNote].item2[1],
                            child: Scrollbar(
                              controller:
                                  notesControllers[selectedNote].item2[0],
                              child: SingleChildScrollView(
                                controller:
                                    notesControllers[selectedNote].item2[0],
                                child: SizedBox(
                                  height: 10000,
                                  width: 10000,
                                  child: Stack(
                                    children: [
                                      Painter(
                                          notesControllers[selectedNote].item1),
                                      Stack(
                                        children: _stackTextBuilder(context),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          child: IconButton(
                            icon: Icon(Icons.undo),
                            onPressed: () {
                              if (!notesControllers[selectedNote]
                                  .item1
                                  .isEmpty) {
                                notesControllers[selectedNote].item1.undo();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Container(),
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
