import 'dart:async';
import 'package:flutter/material.dart';
import 'popuptask_func.dart';
import '../../Theme/themes.dart';

import 'asignee/asignee.dart';
import 'date/date.dart';
import 'location/location.dart';
import 'notes/notes.dart';
import 'repeat/repeat.dart';
import 'taskTypeChooser/taskTypeChooser.dart';
import 'title_color/title_color.dart';
import 'topBar/topBar.dart';

class NewTaskPopup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewTaskPopupState();
}

class NewTaskPopupState extends State<NewTaskPopup> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(Duration(milliseconds: 50), (Timer t) => checkSetState());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentView(),
    );
  }

  Widget currentView() {
    if (typeStatus[0] == buttonColor) {
      return taskView();
    }
    if (typeStatus[1] == buttonColor) {
      return goalView();
    }
    if (typeStatus[2] == buttonColor) {
      return appointmentView();
    }
    return Container();
  }

  Widget taskView() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        topBar(context, pageDesc + typeDesc[0]),
        taskTypeChooser(),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 13.0, right: 13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleAndColorBar(context),
              notesBox(),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 7.0),
                  child: Text(endDesc, style: TextStyle(fontSize: 15))),
              endDate(context),
              Asignee(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget goalView() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        topBar(context, pageDesc + typeDesc[1]),
        taskTypeChooser(),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 13.0, right: 13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleAndColorBar(context),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 7.0),
                  child: Text(endDesc, style: TextStyle(fontSize: 15))),
              endDate(context),
              repeatSwitch(),
              repeatWidget(),
              notesBox(),
            ],
          ),
        ),
      ],
    );
  }

  Widget appointmentView() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        topBar(context, pageDesc + typeDesc[2]),
        taskTypeChooser(),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 13.0, right: 13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleAndColorBar(context),
              SizedBox(
                height: 20,
              ),
              allDaySwitch(),
              Padding(
                  padding: EdgeInsets.only(left: 7.0),
                  child: Text(startDesc, style: TextStyle(fontSize: 15))),
              startDate(context),
              SizedBox(
                height: 10,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 7.0),
                  child: Text(endDesc, style: TextStyle(fontSize: 15))),
              endDate(context),
              repeatSwitch(),
              repeatWidget(),
              locationBox(),
              notesBox(),
            ],
          ),
        ),
      ],
    );
  }

  checkSetState() {
    if (setStateNeeded == true) {
      setState(() {
        setStateNeeded = false;
      });
    }
  }

}
