import 'package:flutter/material.dart';
import '../popuptask_func.dart';

var curr_location;

Widget locationBox() {
  return Padding(
    padding: EdgeInsets.only(left: 7.0, right: 7.0),
    child: TextFormField(
      decoration: InputDecoration(
          border: UnderlineInputBorder(), labelText: locationDesc),
      onChanged: (value) {
        curr_location = value;
      },
    ),
  );
}