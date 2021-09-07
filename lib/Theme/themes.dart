import 'package:aufgabenplaner/CustomIcons/custom_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

bool iosTest = true; //FOR TESTING
bool darkMode = false;

//Colors

void setColorsTry() {
  try {
    primaryColorL = Colors.blue[300];
    primaryColorD = Colors.blue[400];
    buttonColor = Colors.green[200];
    accentColor = Colors.blue[200];
    backgroundL = Colors.white;
    backgroundD = Colors.black45;
    hoverColorL = Colors.blue[50];
  } catch (e) {
    print(
        'could not set platform colors, using default ones. this is normal on web platform');
  }
}

var primaryColorL = Colors.teal[200];
var primaryColorD = Colors.teal[300];
var buttonColor = Colors.deepOrange[300];
var accentColor = Colors.teal[100];
var backgroundL = Colors.white;
var backgroundD = Colors.black45;
var hoverColorL = Colors.teal[50];
var hoverColorD = Colors.grey[600];
var menuBackgroundL = Colors.grey[200];
var menuBackgroundD = Colors.grey[800];
var errorColor = Colors.red;

final iconColor = Colors.black87;
final textColor = Colors.black87;
final greyedColor = Colors.grey[500];

//Icons
void setIconsTry() {
  try {
    if (Platform.isMacOS ||
        defaultTargetPlatform == TargetPlatform.iOS ||
        iosTest == true) {
      menuIcon =
          Icon(CupertinoIcons.line_horizontal_3, color: iconColor); //ellipsis?
      searchIcon = Icon(CupertinoIcons.search, color: iconColor);
      plusIcon = Icon(CupertinoIcons.plus, color: iconColor);
      calendarIcon = Icon(CupertinoIcons.calendar, color: iconColor);
      starIcon = Icon(CupertinoIcons.star_fill, color: iconColor);
      taskIcon = Icon(CupertinoIcons.check_mark_circled, color: iconColor);
      chatIcon = Icon(CupertinoIcons.chat_bubble_text, color: iconColor);
      notesIcon = Icon(CupertinoIcons.doc_plaintext,
          color: iconColor); //text_alignleft?
      contactIcon = Icon(CupertinoIcons.person_2_square_stack,
          color: iconColor); //person_crop_circle?
      settingsIcon =
          Icon(CupertinoIcons.settings, color: iconColor); //gear, gear_alt?
    }
  } catch (e) {
    print(
        'could not set platform icons, using default ones. this is normal on web platform');
  }
}

var menuIcon = Icon(Icons.menu, color: iconColor);
var searchIcon = Icon(Icons.search, color: iconColor);
var plusIcon = Icon(Icons.add, color: iconColor);
var calendarIcon = Icon(Icons.today_sharp, color: iconColor);
var starIcon = Icon(Icons.star, color: iconColor);
var taskIcon = Icon(Icons.check, color: iconColor);
var chatIcon = Icon(CustomIcons.chat_logo, color: iconColor);
var notesIcon = Icon(Icons.notes, color: iconColor);
var contactIcon = Icon(Icons.contacts, color: iconColor);
var settingsIcon = Icon(Icons.settings, color: iconColor);
