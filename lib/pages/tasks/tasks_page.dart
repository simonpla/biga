import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../main.dart';
import '../appBar/appBar.dart';
import '../contacts/contactsFunc.dart';
import '../navigationbar/navigation_bar.dart';
import 'drawerMenu/drawerMenu.dart';
import 'kanban/kanban.dart';

class Task {
  Task(this.title, this.notes, this.end, this.importance, this.asignees, this.group,
      this.recColor);
  String title;
  DateTime end;
  var importance;
  var notes = '';
  List<Contact> asignees;
  var group;
  Color recColor = Colors.blue;
}

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with TickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
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
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context),
      drawer: drawerMenu(context),
      body: Center(child: kanban(context)),
      floatingActionButton: buildLowerNavigation(context, scaffoldKey, 0),
    );
  }

  checkSetState() {
    if (setStateNeeded[4] == true) {
      setState(() {
        setStateNeeded[4] = false;
      });
    }
  }
}

