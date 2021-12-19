import 'package:flutter/material.dart';

DateTime selDateStart = DateTime.now();
DateTime selDateEnd = DateTime.now();
DateTime tempDate = DateTime.now();
TimeOfDay selTimeStart = TimeOfDay.now();
TimeOfDay selTimeEnd = TimeOfDay.now();
TimeOfDay tempTime = TimeOfDay.now();

assignToDateTime(int id, var val) { //assigns value to variable, because it changes with Start and End dates
  switch(id) {
    case 1: selDateStart = val; break;
    case 2: selTimeStart = val; break;
    case 3: selDateEnd = val; break;
    case 4: selTimeEnd = val; break;
  }
}

repeatTextAssign(var value) {
  if(value == true) {
    return 'Repeat every';
  } return 'Repeat';
}