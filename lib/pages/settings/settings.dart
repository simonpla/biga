import 'package:aufgabenplaner/pages/appBar/appBar.dart';
import 'package:aufgabenplaner/pages/navigationbar/navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:aufgabenplaner/pages/tasks/drawerMenu/drawerMenu.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsState();
}

class SettingsState extends State<Settings> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: appBar(context),
      drawer: drawerMenu(context),
      body: Container(
        height: 150,
        child: ListView(
          children: [
          Container(
            height: 100,
          ), // konto and stuff
            Container(
              height: 50,
              child: ListView( // einzelne einstellungen
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ryan reynolds'),
                        Switch(value: false, onChanged: (state) => null),
                      ],
                    ),
                  )
                ],
              ),
            ),
        ],
        ),
      ),
      floatingActionButton: buildLowerNavigation(context, scaffoldKey, -1),
    );
  }
}