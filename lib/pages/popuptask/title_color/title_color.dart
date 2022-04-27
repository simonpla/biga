import 'package:flutter/material.dart';
import '../popuptask_func.dart';

var curr_title;
var availableTaskColors = [
  [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.blue,
  ],
  [
    Colors.green,
    Colors.deepPurple,
    Colors.pink,
    Colors.teal,
  ],
];
var usedTaskColor = Colors.orange;

Widget titleAndColorBar(context) {
  return Padding(
    padding: EdgeInsets.only(left: 7.0, right: 7.0),
    child: Row(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 14 - 80,
          child: TextFormField(
            decoration: InputDecoration(
                border: UnderlineInputBorder(), labelText: titleDesc),
            onChanged: (value) {
              curr_title = value;
            },
          ),
        ),
        Spacer(),
        SizedBox(
          width: 40,
          child: RawMaterialButton(
            onPressed: () => colorPicker(context),
            elevation: 0.0,
            fillColor: usedTaskColor,
            child: Container(),
            padding: EdgeInsets.all(15.0),
            shape: CircleBorder(),
          ),
        ),
      ],
    ),
  );
}

colorPicker(context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) => SimpleDialog(
      title: Center(child: Text(colorPickerDesc)),
      children: [
        Center(
          child: Container(
            width: 300,
            height: 130,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    colorColumn(context, 0, availableTaskColors),
                    colorColumn(context, 1, availableTaskColors),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget colorColumn(context, d1, colors) {
  return Row(
    children: [
      colorBox(context, d1, 0, colors),
      colorBox(context, d1, 1, colors),
      colorBox(context, d1, 2, colors),
      colorBox(context, d1, 3, colors),
    ],
  );
}

Widget colorBox(context, d1, d2, colors) {
  return SizedBox(
    width: 60,
    child: RawMaterialButton(
      onPressed: () {
        usedTaskColor = colors[d1][d2];
        Navigator.pop(context, true);
        setStateNeeded = true;
      },
      elevation: 0.0,
      fillColor: colors[d1][d2],
      child: Container(),
      padding: EdgeInsets.all(15.0),
      shape: CircleBorder(),
    ),
  );
}
