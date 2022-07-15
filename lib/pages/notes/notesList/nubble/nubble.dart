import 'package:flutter/material.dart';

class Triangle {
  Triangle._();

  static const _kFontFam = 'Triangle';
  static const String? _kFontPkg = null;

  static const IconData round = IconData(0xe800, fontFamily: _kFontFam, fontPackage: _kFontPkg);
}

Widget getNubble() {
  return Transform.rotate(
    angle: 89.6,
    child: Icon(
      Triangle.round,
      color: Colors.white,
      size: 40,
    ),
  );
}
