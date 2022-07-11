import 'dart:async';

import 'package:aufgabenplaner/Theme/themes.dart';
import 'package:aufgabenplaner/pages/contacts/contactsFunc.dart';
import 'package:aufgabenplaner/pages/popuptask/taskGroup/taskGroup.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

//TODO: implement a groups solution for whole app
List<Pair<String, Color?>> groups1 = [
  Pair<String, Color?>('project 1', Colors.purple[200]),
  Pair<String, Color?>('project 2', Colors.purple[200]),
  Pair<String, Color?>('project 3', Colors.purple[200]),
  Pair<String, Color?>('project 4', Colors.purple[200]),
  Pair<String, Color?>('project 5', Colors.purple[200]),
  Pair<String, Color?>('project 6', Colors.purple[200]),
];
List<Pair<String, Color?>> filtered_groups1 = [...groups1]; // clone items
List<Pair<String, Color?>> used_groups1 = [];

class NewContactPopup extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NewContactPopupState();
}

class NewContactPopupState extends State<NewContactPopup> {
  Timer? timer;
  final nameController = TextEditingController();
  final mailController = TextEditingController();
  final telController = TextEditingController();
  final companyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(milliseconds: 1), (Timer t) {
      checkSetState();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Spacer(),
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: closeIcon,
                  iconSize: 23),
              Spacer(flex: 80),
              Text('create new contact',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              Spacer(flex: 80),
              ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        telController.text.isNotEmpty &&
                        mailController.text.isNotEmpty &&
                        companyController.text.isNotEmpty &&
                        used_groups1.isNotEmpty) {
                      newContact(
                          nameController.text,
                          telController.text,
                          mailController.text,
                          companyController.text,
                          used_groups1[0].item1);
                    }
                    Navigator.pop(context);
                    setStateNeeded[2] = true;
                  },
                  child: Text('save')),
              Spacer(flex: 2),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'name',
                  ),
                ),
                TextField(
                  controller: mailController,
                  decoration: InputDecoration(
                    labelText: 'email',
                  ),
                ),
                TextField(
                  controller: telController,
                  decoration: InputDecoration(
                    labelText: 'phone number',
                  ),
                ),
                TextField(
                  controller: companyController,
                  decoration: InputDecoration(
                    labelText: 'company',
                  ),
                ),
                SizedBox(height: 10),
                TaskGroup(context, groups1, filtered_groups1, used_groups1, 1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  checkSetState() {
    if (setStateNeeded[1] == true) {
      setState(() {
        setStateNeeded[1] = false;
      });
    }
  }
}
