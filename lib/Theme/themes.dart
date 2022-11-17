import 'package:aufgabenplaner/CustomIcons/custom_icons_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/services.dart';

bool iosTest = false; //FOR TESTING
bool windowsTest = false; //FOR TESTING
bool darkMode = false;

//Colors
//TODO: make dark mode work (now: different shades of grey)

var uBackground, uTextColor;

void setColorsTry() {
  /*try {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        Platform.isMacOS == true ||
        iosTest == true) {
      primaryColorL = Colors.blue[300];
      primaryColorD = Colors.blue[400];
      buttonColor = Colors.green[200];
      accentColor = Colors.blue[200];
      backgroundL = Colors.white;
      backgroundD = Colors.black45;
      hoverColorL = Colors.blue[50];
    }
  } catch (e) {
    print(
        'could not set platform colors, using default ones. this is normal on web platform');
  }
  uBackground = darkMode == true ? backgroundD : Colors.white24;
  uTextColor = darkMode == true ? textColorD : textColorL;
  backgroundDay = darkMode == true ? backgroundD : Colors.grey.shade100;*/
}
/*
var primaryColorL = Colors.teal[200];
var primaryColorD = Colors.teal[300];
var buttonColor = Colors.deepOrange[300];
var accentColor = Colors.teal[100];
var backgroundL = Colors.white24;
var backgroundD = Colors.black45;
var hoverColorL = Colors.teal[50];
var hoverColorD = Colors.grey[600];
var menuBackgroundL = Colors.grey[200];
var menuBackgroundD = Colors.grey[800];
var errorColor = Colors.red;
var textColorD = Colors.white;
var textColorL = Colors.black87;
var backgroundDay = Colors.grey.shade100;
*/
final iconColor = Colors.black87;
final greyedColor = Colors.grey[500];

final defaultTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSwatch()
      .copyWith(secondary: Colors.deepOrange[300], brightness: Brightness.dark),
  appBarTheme: AppBarTheme(
      backgroundColor: Colors.lightBlueAccent,
      iconTheme: IconThemeData(color: Colors.deepOrange[300])),
  buttonTheme: ButtonThemeData(buttonColor: Colors.deepOrange[300]),
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: Colors.deepOrange[300]),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(Colors.deepOrange[300]!),
      textStyle: MaterialStateProperty.resolveWith(
          (_) => TextStyle(color: Colors.white)),
    ),
  ),
  iconTheme: IconThemeData(color: Colors.deepOrange[300]),
  canvasColor: Colors.grey[900],
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
    labelStyle: TextStyle(color: Colors.white),
  ),
);

//Icons
void setIconsTry() {
  try {
    if (defaultTargetPlatform == TargetPlatform.iOS ||
        Platform.isMacOS == true ||
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
      closeIcon = Icon(CupertinoIcons.xmark, color: iconColor);
      doneIcon = Icon(CupertinoIcons.check_mark, color: iconColor);
    }

    if (Platform.isWindows || windowsTest == true) {
      menuIcon = Icon(FluentIcons.navigation_24_regular, color: iconColor);
      searchIcon = Icon(FluentIcons.search_24_regular, color: iconColor);
      plusIcon = Icon(FluentIcons.add_24_regular, color: iconColor);
      calendarIcon =
          Icon(FluentIcons.calendar_ltr_24_regular, color: iconColor);
      starIcon = Icon(FluentIcons.star_24_regular, color: iconColor);
      taskIcon = Icon(FluentIcons.tasks_app_24_regular, color: iconColor);
      chatIcon = Icon(FluentIcons.chat_24_regular, color: iconColor);
      notesIcon =
          Icon(FluentIcons.text_align_left_24_regular, color: iconColor);
      contactIcon = Icon(FluentIcons.contact_card_group_24_regular,
          color: iconColor); // personCircle24Regular
      settingsIcon = Icon(FluentIcons.settings_24_regular, color: iconColor);
      iconsMenuChooseCalendarLayout[0] = FluentIcons.calendar_agenda_24_regular;
      iconsMenuChooseCalendarLayout[1] = FluentIcons.calendar_day_24_regular;
      iconsMenuChooseCalendarLayout[2] =
          FluentIcons.calendar_week_numbers_24_regular;
      iconsMenuChooseCalendarLayout[3] = FluentIcons.calendar_month_24_regular;
      closeIcon = Icon(FluentIcons.dismiss_24_regular, color: iconColor);
      doneIcon = Icon(FluentIcons.check_24_regular, color: iconColor);
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
var closeIcon = Icon(Icons.close, color: iconColor);
var doneIcon = Icon(Icons.check, color: iconColor);
List<IconData> iconsMenuChooseCalendarLayout = [
  Icons.view_agenda_outlined,
  Icons.view_day_outlined,
  Icons.calendar_view_week_outlined,
  Icons.calendar_view_month_outlined
];
