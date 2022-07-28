import 'package:flutter/material.dart';
import '../../../Theme/themes.dart';
import '../../../main.dart';
import '../popuptask_func.dart';

var typeStatus = [buttonColor, Colors.white];

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
            setStateNeeded[0] = true;
          },
          child: Text(typeDesc[0]),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          border: Border.all(color: buttonColor!),
          color: typeStatus[1],
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(5), bottomRight: Radius.circular(5)),
        ),
        child: TextButton(
          onPressed: () {
            if (typeStatus[0] != Colors.white) {
              typeStatus[0] = Colors.white;
            } //same as above
            if (typeStatus[1] != buttonColor) {
              typeStatus[1] = buttonColor;
            }
            setStateNeeded[0] = true;
          },
          child: Text(typeDesc[1]),
        ),
      ),
      Spacer(),
    ],
  );
}
