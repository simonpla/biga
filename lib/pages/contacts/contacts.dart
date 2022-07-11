import 'dart:async';

import 'package:aufgabenplaner/pages/chat/newChatPopup.dart';
import 'package:aufgabenplaner/pages/contacts/contactsFunc.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../appBar/appBar.dart';
import '../menuDrawer/menuDrawer.dart';
import '../navigationbar/navigation_bar.dart';
import 'contactsListDisplay/contactsListDisplay.dart';

//List<Contact> contacts = List<Contact>.generate(23, (i) => Contact('TomTom der $i', '0343 78975667', 'tomtom@cool.com', 'Team $i'));

class Contacts extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ContactsState();
}

class ContactsState extends State<Contacts> {
  Timer? timer;
  var scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: scaffoldKey,
      appBar: appBar(context),
      drawer: menuDrawer(context),
      body: Padding(
        padding: EdgeInsets.only(left: 20, top: 10, right: 20),
        child: Row(
          children: [
            Expanded(child: contactsListDisplay(context)),
          ],
        ),
      ),
      floatingActionButton: buildLowerNavigation(context, scaffoldKey, 1),
    );
  }

  checkSetState() {
    if (setStateNeeded[2] == true) {
      setState(() {
        setStateNeeded[2] = false;
      });
    }
  }
}