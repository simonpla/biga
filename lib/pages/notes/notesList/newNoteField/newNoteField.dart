import 'package:aufgabenplaner/pages/notes/notes.dart';
import 'package:flutter/material.dart';

import '../../../../database/database.dart';
import '../../../../main.dart';
import '../notesList.dart';

var newTextFocus = FocusNode();

Widget newNoteField(orgContext, indexNL) {
  return Row(
    children: [
      SizedBox(width: MediaQuery.of(orgContext).size.width / 50),
      getBar(-1),
      Container(
        width: MediaQuery.of(orgContext).size.width / 4.5 > 300
            ? 150
            : MediaQuery.of(orgContext).size.width * 0.20 - 30,
        padding: EdgeInsets.only(left: 5, right: 5),
        child: TextField(
          cursorColor: Colors.white,
          focusNode: newTextFocus,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1.5, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2.0, color: Colors.white),
            ),
            contentPadding: EdgeInsets.all(8),
            isDense: true,
          ),
          onSubmitted: (value) async {
            notes.add(PairNL(value, Colors.grey[400]));
            notes[selectedNote].item2 = Colors.grey[400];
            selectedNote = notes.length - 1;
            textFields.add(List.empty(growable: true));
            setStateNeeded[5] = true;
            newNote = false;
            hasChangedText.add(List.empty(growable: true));
            counterLines.add(List.empty(growable: true));
            await connection.transaction((ctx) async {
              await ctx.query("INSERT INTO notes VALUES (@a, @b)", substitutionValues: {
                "a": notesControllers.length - 1,
                "b": value,
              });
            });
          },
        ),
      ),
    ],
  );
}
