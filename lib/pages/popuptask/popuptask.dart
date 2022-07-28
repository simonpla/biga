import 'dart:async';
import 'package:flutter/material.dart';
import '../../main.dart';
import 'popuptask_func.dart';
import '../../Theme/themes.dart';

import 'asignee/asignee.dart';
import 'date/date.dart';
import 'notes/notes.dart';
import 'repeat/repeat.dart';
import 'taskGroup/taskGroup.dart';
import 'taskTypeChooser/taskTypeChooser.dart';
import 'title_color/title_color.dart';
import 'topBar/topBar.dart';

var showError = false;

class NewTaskPopup extends StatefulWidget {
  final fromId;

  NewTaskPopup(this.fromId, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => NewTaskPopupState();
}

class NewTaskPopupState extends State<NewTaskPopup> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer =
        Timer.periodic(Duration(milliseconds: 1), (Timer t) => checkSetState());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: currentView(widget.fromId),
    );
  }

  Widget currentView(fromId) {
    if (typeStatus[0] == buttonColor) {
      return taskView(fromId);
    }
    if (typeStatus[1] == buttonColor) {
      return goalView(fromId);
    }
    return Container();
  }

  Widget taskView(fromId) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        topBar(context, pageDesc + typeDesc[0], fromId),
        taskTypeChooser(),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 13.0, right: 13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                  child: Text(
                    'Error: Please fill out all fields',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                visible: showError,
              ),
              titleAndColorBar(context),
              notesBox(),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.only(left: 7.0),
                  child: Text(endDesc, style: TextStyle(fontSize: 15))),
              endDate(context),
              SizedBox(
                height: 20,
              ),
              Asignee(context),
              SizedBox(
                height: 20,
              ),
              TaskGroup(context, groups, filtered_groups, used_groups, 0),
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget goalView(fromId) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: [
        topBar(context, pageDesc + typeDesc[1], fromId),
        taskTypeChooser(),
        SizedBox(height: 10),
        Padding(
          padding: EdgeInsets.only(left: 13.0, right: 13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Visibility(
                child: Text(
                  'Error: Please fill out all fields',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                visible: showError,
              ),
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }

  checkSetState() {
    if (setStateNeeded[0] == true) {
      setState(() {
        setStateNeeded[0] = false;
      });
    }
  }
}
