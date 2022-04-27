import 'package:flutter/material.dart';
import '../../../Theme/themes.dart';
import '../popuptask_func.dart';

var typeStatus = [Colors.white, Colors.white, buttonColor];

Widget taskTypeChooser() {
  return Row(
    children: [
      Spacer(),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: buttonColor!),
          color: typeStatus[0],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), bottomLeft: Radius.circular(5)),
        ),
        child: TextButton(
          onPressed: () {
            if (typeStatus[0] != buttonColor) {
              typeStatus[0] = buttonColor;
            } //change selection if not already selected
            if (typeStatus[1] != Colors.white) {
              typeStatus[1] = Colors.white;
            }
            if (typeStatus[2] != Colors.white) {
              typeStatus[2] = Colors.white;
            }
            setStateNeeded = true;
          },
          child: Text(typeDesc[0]),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: buttonColor!),
          color: typeStatus[1],
        ),
        child: TextButton(
          onPressed: () {
            if (typeStatus[0] != Colors.white) {
              typeStatus[0] = Colors.white;
            } //same as above
            if (typeStatus[1] != buttonColor) {
              typeStatus[1] = buttonColor;
            }
            if (typeStatus[2] != Colors.white) {
              typeStatus[2] = Colors.white;
            }
            setStateNeeded = true;
          },
          child: Text(typeDesc[1]),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: buttonColor!),
          color: typeStatus[2],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
        ),
        child: TextButton(
          onPressed: () {
            if (typeStatus[0] != Colors.white) {
              typeStatus[0] = Colors.white;
            } //same as above
            if (typeStatus[1] != Colors.white) {
              typeStatus[1] = Colors.white;
            }
            if (typeStatus[2] != buttonColor) {
              typeStatus[2] = buttonColor;
            }
            setStateNeeded = true;
          },
          child: Text(typeDesc[2]),
        ),
      ),
      Spacer(),
    ],
  );
}
