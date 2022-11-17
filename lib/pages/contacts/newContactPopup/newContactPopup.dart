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
    setStateNeeded[2] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.only(left: 13, top: 5, right: 13, bottom: 13),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                //Spacer(),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: closeIcon,
                    iconSize: 23),
                //Spacer(flex: 80),
                Expanded(
                  child: Text(
                    'create new contact',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    overflow: TextOverflow.clip,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
                //Spacer(flex: 80),
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
                //Spacer(flex: 2),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: nameController,
                      cursorColor: Colors.deepPurpleAccent[200],
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.7),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepPurpleAccent[200]!, width: 0.7),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        contentPadding: EdgeInsets.only(left: 7, top: 4),
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        labelText: 'name',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: mailController,
                      cursorColor: Colors.deepPurpleAccent[200],
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.7),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepPurpleAccent[200]!, width: 0.7),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        contentPadding: EdgeInsets.only(left: 7, top: 4),
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        labelText: 'email',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: telController,
                      cursorColor: Colors.deepPurpleAccent[200],
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.7),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepPurpleAccent[200]!, width: 0.7),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        contentPadding: EdgeInsets.only(left: 7, top: 4),
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        labelText: 'phone number',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: companyController,
                      cursorColor: Colors.deepPurpleAccent[200],
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.7),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.deepPurpleAccent[200]!, width: 0.7),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        contentPadding: EdgeInsets.only(left: 7, top: 4),
                        floatingLabelStyle: TextStyle(color: Colors.white),
                        labelText: 'company',
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TaskGroup(
                      context, groups1, filtered_groups1, used_groups1, 1),
                ],
              ),
            ),
          ],
        ),
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
