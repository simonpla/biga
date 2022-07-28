import 'package:flutter/material.dart';

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
          onSubmitted: (value) {
            notes.add(Pair(value, Colors.grey[600]));
            notes[selectedNote].item2 = Colors.grey[600];
            selectedNote = notes.length - 1;
            //notes[notes.length - 1].item2 = Colors.white;
            setStateNeeded[5] = true;
            newNote = false;
          },
        ),
      ),
    ],
  );
}
