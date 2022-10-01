import 'package:flutter/material.dart';

import '../../../Theme/themes.dart';

Widget drawerMenu(context) {
  return Drawer(
    child: Container(
      color: uBackground,
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 170,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: accentColor,
              ),
              child: Column(
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Foo Bar Baz'),
                    ),
                  ),
                  Container(height: 10.0),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('foo.bar.baz@example.com'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ExpansionTile(
            leading: Container(
              child: taskIcon,
            ),
            title: Text('Tasks', style: TextStyle(color: uTextColor)),
            children: [
              ListTile(
                title: Text(
                  'board',
                  style: TextStyle(color: uTextColor),
                ),
                onTap: () => Navigator.pushNamed(context, '/kanban'),
                hoverColor: hoverColorL,
              ),
              ListTile(
                title: Text(
                  'timeline',
                  style: TextStyle(color: uTextColor),
                ),
                onTap: () => Navigator.pushNamed(context, '/timeline'),
                hoverColor: hoverColorL,
              ),
            ],
          ),
          ListTile(
            leading: Container(
              child: chatIcon,
            ),
            title: Text('Chat', style: TextStyle(color: uTextColor)),
            onTap: () => Navigator.pushNamed(context, '/chat'),
            hoverColor: hoverColorL,
          ),
          ListTile(
            leading: Container(
              child: notesIcon,
            ),
            title: Text('Notes', style: TextStyle(color: uTextColor)),
            onTap: () => Navigator.pushNamed(context, '/notes'),
            hoverColor: hoverColorL,
          ),
          ListTile(
            leading: Container(
              child: contactIcon,
            ),
            title: Text('Contacts', style: TextStyle(color: uTextColor)),
            onTap: () => Navigator.pushNamed(context, '/contacts'),
            hoverColor: hoverColorL,
          ),
          ListTile(
            leading: Container(
              child: settingsIcon,
            ),
            title: Text('Settings', style: TextStyle(color: uTextColor)),
            onTap: () => Navigator.pushNamed(context, '/settings'),
            hoverColor: hoverColorL,
          ),
        ],
      ),
    ),
  );
}