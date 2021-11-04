import 'package:flutter/material.dart';

DateTime selDateStart = DateTime.now();
DateTime selDateEnd = DateTime.now();
late DateTime tempDate;
TimeOfDay selTimeStart = TimeOfDay.now();
TimeOfDay selTimeEnd = TimeOfDay.now();
late TimeOfDay tempTime;

void assignToDateTime(int id, var val) {
  switch(id) {
    case 1: selDateStart = val; break;
    case 2: selTimeStart = val; break;
    case 3: selDateEnd = val; break;
    case 4: selTimeEnd = val; break;
  }
}