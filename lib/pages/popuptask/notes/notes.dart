import 'package:flutter/material.dart';
import '../popuptask_func.dart';

var curr_notes;
TextEditingController notesController = TextEditingController();

Widget notesBox(context) {
  return Padding(
    padding: EdgeInsets.only(left: 7.0, right: 7.0),
    child: TextField(
      controller: notesController,
      cursorColor: Colors.white,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        border: Theme.of(context).inputDecorationTheme.border,
        focusedBorder: Theme.of(context).inputDecorationTheme.border,
        enabledBorder: Theme.of(context).inputDecorationTheme.border,
        labelText: notesDesc,
        labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
      ),
      onChanged: (value) {
        curr_notes = value;
      },
    ),
  );
}