import 'package:flutter/material.dart';
import '../../../Theme/themes.dart';
import '../popuptask_func.dart';

Widget topBar(context, pageDescription) {
  return Row(
    children: [
      Spacer(),
      IconButton(
          onPressed: () => Navigator.pop(context),
          icon: closeIcon,
          iconSize: 23),
      Spacer(flex: 80),
      Text(pageDescription,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
      Spacer(flex: 80),
      ElevatedButton(
          onPressed: () => Navigator.pop(context), child: Text(saveDesc)),
      Spacer(flex: 2),
    ],
  );
}
