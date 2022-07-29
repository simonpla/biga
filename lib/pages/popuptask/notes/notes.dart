import 'package:flutter/material.dart';
import '../popuptask_func.dart';

var curr_notes;
TextEditingController notesController = TextEditingController();

Widget notesBox() {
  return Padding(
    padding: EdgeInsets.only(left: 7.0, right: 7.0),
    child: TextField(
      controller: notesController,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        labelText: notesDesc,
      ),
      onChanged: (value) {
        curr_notes = value;
      },
    ),
  );
}