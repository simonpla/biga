import 'package:aufgabenplaner/main.dart';
import 'package:aufgabenplaner/pages/notes/notesList/newNoteField/newNoteField.dart';
import 'package:aufgabenplaner/pages/notes/notesList/nubble/nubble.dart';
import 'package:flutter/material.dart';

class Pair<T1, T2> {
  T1 item1;
  T2 item2;

  Pair(this.item1, this.item2);
}

var selectedNote = 0;
List<Pair<String, Color?>> notes = List.generate(
    17, (index) => Pair('Tom$index', Colors.grey[600]),
    growable: true);
var newNote = false;
var NSC = ScrollController();

Widget notesList(orgContext) {
  if (notes[selectedNote].item2 != Colors.white) {
    notes[selectedNote].item2 = Colors.white;
  }
  return Container(
    width: MediaQuery.of(orgContext).size.width / 4.5 > 300
        ? 250
        : MediaQuery.of(orgContext).size.width / 4.5,
    color: Color(0xfff2d3cb),
    child: ListView(
      controller: NSC,
      children: [
        Stack(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: newNote ? notes.length + 1 : notes.length,
              itemBuilder: (context, indexNL) {
                if (indexNL == notes.length && newNote) {
                  return newNoteField(orgContext, indexNL);
                } else {
                  return Row(
                    children: [
                      SizedBox(
                          width: MediaQuery.of(orgContext).size.width / 50),
                      getBar(indexNL),
                      SizedBox(
                        width: MediaQuery.of(orgContext).size.width / 4.5 > 300
                            ? 150
                            : MediaQuery.of(orgContext).size.width * 0.20 - 30,
                        child: Row(
                          children: [
                            SizedBox(width: indexNL == selectedNote ? 30 : 20),
                            Expanded(
                              child: InkWell(
                                child: Text(
                                  notes[indexNL].item1,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: notes[indexNL].item2),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  notes[selectedNote].item2 = Colors.grey[600];
                                  selectedNote = indexNL;
                                  setStateNeeded[5] = true;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              left: MediaQuery.of(orgContext).size.width / 50 + 12,
              top: selectedNote * 60 + 11,
              child: getNubble(),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget getBar(index) {
  if (index == 0) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          height: 50,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
        ),
      ],
    );
  } else if ((index == notes.length - 1 && !newNote) || index == -1) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  } else {
    return Container(
      height: 60,
      width: 30,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}
