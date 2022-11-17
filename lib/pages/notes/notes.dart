import 'dart:async';
import 'package:aufgabenplaner/pages/appBar/appBar.dart';
import 'package:aufgabenplaner/pages/navigationbar/navigation_bar.dart';
import 'package:aufgabenplaner/pages/notes/notesList/notesList.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../database/database.dart';
import '../../main.dart';
import '../tasks/drawerMenu/drawerMenu.dart';
import 'package:hand_signature/signature.dart';

List<PairNL<HandSignatureControl, List<ScrollController>>>
    notesControllers = // controls painter and x,y scrolling controller
    List.empty(growable: true);

List<List<PairNL<PairNL<TextEditingController, FocusNode>, List<double>>>>
    textFields = List.generate(
        notesControllers.length,
        (index) => List.generate(
            0,
            (index) =>
                PairNL(PairNL(TextEditingController(), FocusNode()), [0, 0])));

List<List<int>> counterLines = List.empty(growable: true);

List<ScrollController> scroll = [];

List<List<PairNL<String, List<double>>>> hasChangedText =
    List.empty(growable: true);

List<PairNL<int, Map<String, dynamic>>> hasChangedCanvas =
    List.empty(growable: true);

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
            cursorColor: Colors.white,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 0, color: Colors.transparent)),
              focusedBorder: Theme.of(orgContext).inputDecorationTheme.border,
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
              for (int j = 0; j < hasChangedText[selectedNote].length; j++) {
                if (hasChangedText[selectedNote][j].item2 ==
                    textFields[selectedNote][i].item2) {
                  alreadyChanged = j;
                }
              }
              if (alreadyChanged == -1) {
                hasChangedText[selectedNote]
                    .add(PairNL(value, textFields[selectedNote][i].item2));
              } else {
                hasChangedText[selectedNote][alreadyChanged].item1 = value;
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
        notesControllers[selectedNote].item1.stepBack();
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
        for (int i = 0; i < hasChangedText.length; i++) {
          for (int j = 0; j < hasChangedText[i].length; j++) {
            await ctx.query("DELETE FROM notesText WHERE pos=@a",
                substitutionValues: {
                  "a":
                      '${hasChangedText[i][j].item2[0]},${hasChangedText[i][j].item2[1]}',
                });

            await ctx.query("INSERT INTO notesText VALUES (@a, @b, @c)",
                substitutionValues: {
                  "a": i,
                  "b": hasChangedText[i][j].item1,
                  "c":
                      '${hasChangedText[i][j].item2[0]},${hasChangedText[i][j].item2[1]}',
                });

            hasChangedText[i].clear();
          }
        }

        for (int i = 0; i < hasChangedCanvas.length; i++) {
          await ctx.query("DELETE FROM notesCanvas WHERE id=@a",
              substitutionValues: {
                "a": hasChangedCanvas[i].item1,
              });

          await ctx.query("INSERT INTO notesCanvas VALUES (@a, @b)",
              substitutionValues: {
                "a": hasChangedCanvas[i].item1,
                "b": hasChangedCanvas[i].item2,
              });
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
                        bool _shiftPressed() {
                          bool isShiftPressed = false;
                          RawKeyboard.instance.keysPressed.forEach((element) {
                            if (element == LogicalKeyboardKey.shift ||
                                element == LogicalKeyboardKey.shiftLeft) {
                              isShiftPressed = true;
                            }
                          });
                          return isShiftPressed;
                        }

                        if (_shiftPressed()) {
                          textFields[selectedNote].add(PairNL(
                              PairNL(TextEditingController(), FocusNode()), [
                            details.position.dx +
                                notesControllers[selectedNote].item2[1].offset,
                            details.position.dy +
                                notesControllers[selectedNote].item2[0].offset
                          ]));
                          notesControllers[selectedNote].item1.stepBack();
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
                                      Container(
                                        constraints: BoxConstraints.expand(),
                                        child: HandSignature(
                                          control:
                                              notesControllers[selectedNote]
                                                  .item1,
                                          width: 3.0,
                                          maxWidth: 3.0,
                                          color: Colors.white,
                                          type: SignatureDrawType.shape,
                                          onPointerUp: () {
                                            var canvasJSON =
                                                notesControllers[selectedNote]
                                                    .item1
                                                    .toMap();

                                            var alreadyChanged = -1;
                                            for (int j = 0;
                                                j < hasChangedCanvas.length;
                                                j++) {
                                              if (hasChangedCanvas[j] ==
                                                  canvasJSON) {
                                                alreadyChanged = j;
                                              }
                                            }
                                            if (alreadyChanged == -1) {
                                              hasChangedCanvas.add(PairNL(
                                                  selectedNote, canvasJSON));
                                            } else {
                                              hasChangedCanvas[alreadyChanged]
                                                  .item2 = canvasJSON;
                                            }
                                          },
                                        ),
                                      ),
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
                              notesControllers[selectedNote].item1.stepBack();
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
