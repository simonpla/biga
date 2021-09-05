import 'package:aufgabenplaner/CustomIcons/custom_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

//Colors

final ThemeData kIOSTheme = ThemeData();

final ThemeData kDefaultTheme = ThemeData();

//Icons
void setIconsTry() {
  try {
    if (Platform.isMacOS || defaultTargetPlatform == TargetPlatform.iOS) {
      final menuIcon = Icon(CupertinoIcons.line_horizontal_3); //ellipsis?
      final searchIcon = Icon(CupertinoIcons.search);
      final plusIcon = Icon(CupertinoIcons.plus);
      final calendarIcon = Icon(CupertinoIcons.calendar);
      final starIcon = Icon(CupertinoIcons.star);
      final taskIcon = Icon(CupertinoIcons.check_mark_circled);
      final chatIcon = Icon(CupertinoIcons.chat_bubble_text);
      final notesIcon = Icon(CupertinoIcons.doc_plaintext); //text_alignleft?
      final contactIcon =
      Icon(CupertinoIcons.person_2_square_stack); //person_crop_circle?
      final settingsIcon = Icon(CupertinoIcons.settings); //gear, gear_alt?
    }
  } catch(e) {
    print('could not set platform widgets, using default ones. this is normal on web platform');
  }
}

final menuIcon = Icon(Icons.menu);
final searchIcon = Icon(Icons.search);
final plusIcon = Icon(Icons.add);
final calendarIcon = Icon(Icons.today_sharp);
final starIcon = Icon(Icons.star);
final taskIcon = Icon(Icons.check);
final chatIcon = Icon(CustomIcons.chat_logo);
final notesIcon = Icon(Icons.notes);
final contactIcon = Icon(Icons.contacts);
final settingsIcon = Icon(Icons.settings);