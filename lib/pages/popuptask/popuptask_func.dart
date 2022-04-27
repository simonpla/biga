import 'package:flutter/material.dart';
import 'location/location.dart';
import 'title_color/title_color.dart';
import '../../calendar/functions/calendarFunc.dart';

var setStateNeeded = false;

var pageDesc = 'create new ';
var typeDesc = ['task', 'goal', 'appointment'];
var saveDesc = 'save';
var titleDesc = 'title';
var colorPickerDesc = 'pick a color';
var allDayDesc = 'all-day';
var startDesc = 'start';
var endDesc = 'end';
var repeatDesc = 'repeat';
var repeatOptionsDesc = ['  hour', '  day', '  week', '  month', '  year'];
var locationDesc = 'location';
var notesDesc = 'notes';

saveTask() {
  var newTask = Task(
    curr_title,
    DateTime.now(),
    DateTime.now(),
    1,
    curr_location, //TODO: add importance chooser to GUI
    Colors.black, //add that too
  );
}