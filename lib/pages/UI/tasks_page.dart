import '../../calendar/UI/calendar.dart';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import '../../CustomIcons/custom_icons_icons.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with TickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int selected = 3;

  void _handlePressed() {}

  Widget _buildNavigation() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Row(
        children: [
          Container(
              height: 30,
              width: MediaQuery.of(context).size.width / 2 > 250
                  ? (MediaQuery.of(context).size.width - 250) / 2 - 10
                  : MediaQuery.of(context).size.width / 4 - 10),
          RowSuper(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.teal[200],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(19),
                    topLeft: Radius.circular(19),
                  ),
                ),
                height: 40,
                width: MediaQuery.of(context).size.width / 2 > 250
                    ? 250
                    : MediaQuery.of(context).size.width / 2,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 > 250
                          ? 50
                          : MediaQuery.of(context).size.width / 10,
                      height: 10,
                    ),
                    Container(
                      child: IconButton(
                        icon: const Icon(Icons.menu),
                        onPressed: () => scaffoldKey.currentState!.openDrawer(),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 > 250
                          ? 50
                          : MediaQuery.of(context).size.width / 10,
                      height: 10,
                    ),
                    Container(
                      child: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () => null,
                      ),
                    ),
                  ],
                ),
              ),
              FloatingActionButton(
                onPressed: () => _handlePressed(),
                child: const Icon(Icons.add),
                backgroundColor: Colors.deepOrangeAccent,
              ),
            ],
            innerDistance: -8,
          ),
        ],
      ),
    );
  }

  Widget _menu() {
    return Drawer(
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 170,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal[100],
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
          ListTile(
            leading: Container(
              child: Icon(Icons.task, color: Colors.black87),
            ),
            title: Text('Tasks', style: TextStyle(color: Colors.black87)),
            onTap: () => Navigator.pushNamed(context, '/tasks'),
            hoverColor: Colors.deepOrangeAccent[100],
          ),
          ListTile(
            leading: Container(
              child: Icon(CustomIcons.chat_logo, color: Colors.black87),
            ),
            title: Text('Chat', style: TextStyle(color: Colors.black87)),
            onTap: () => Navigator.pushNamed(context, '/chat'),
            hoverColor: Colors.deepOrangeAccent[100],
          ),
          ListTile(
            leading: Container(
              child: Icon(Icons.notes, color: Colors.black87),
            ),
            title: Text('Notes', style: TextStyle(color: Colors.black87)),
            onTap: () => Navigator.pushNamed(context, '/notes'),
            hoverColor: Colors.deepOrangeAccent[100],
          ),
          ListTile(
            leading: Container(
              child: Icon(Icons.contacts, color: Colors.black87),
            ),
            title: Text('Contacts', style: TextStyle(color: Colors.black87)),
            onTap: () => Navigator.pushNamed(context, '/contacts'),
            hoverColor: Colors.deepOrangeAccent[100],
          ),
          ListTile(
            leading: Container(
              child: Icon(Icons.settings, color: Colors.black87),
            ),
            title: Text('Settings', style: TextStyle(color: Colors.black87)),
            onTap: () => Navigator.pushNamed(context, '/settings'),
            hoverColor: Colors.deepOrangeAccent[100],
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _appBar() {
    List<IconData> icons = [
      Icons.view_agenda_outlined,
      Icons.view_day_outlined,
      Icons.calendar_view_week_outlined,
      Icons.calendar_view_month_outlined
    ];
    List<String> items = ['appointments', 'day', 'week', 'month'];

    return AppBar(
      backgroundColor: Colors.teal[100],
      leading: Container(
        width: 20,
      ),
      title: Container(
        child: RowSuper(
          children: [
            MediaQuery.of(context).size.width > 800
                ? Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                      color: Colors.black87,
                      icon: Icon(Icons.star),
                      onPressed: () => null,
                    ),
                  )
                : null,
            MediaQuery.of(context).size.width > 670
                ? Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                      color: Colors.black87,
                      icon: Icon(Icons.star),
                      onPressed: () => null,
                    ),
                  )
                : null,
            MediaQuery.of(context).size.width > 550
                ? Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                      color: Colors.black87,
                      icon: Icon(Icons.star),
                      onPressed: () => null,
                    ),
                  )
                : null,
            MediaQuery.of(context).size.width > 300
                ? Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepOrangeAccent,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                      color: Colors.black87,
                      icon: Icon(Icons.star),
                      onPressed: () => null,
                    ),
                  )
                : null,
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: IconButton(
                color: Colors.black87,
                icon: Icon(Icons.star),
                onPressed: () => null,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: PopupMenuButton<int>(
                offset: Offset(60, 30),
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Center(
                    child: Icon(
                  Icons.today_sharp,
                  color: Colors.black87,
                )),
                itemBuilder: (context) {
                  return List.generate(4, (index) {
                    return PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(icons[index], color: Colors.black87),
                          Container(width: 13),
                          Text(items[index]),
                        ],
                      ),
                    );
                  });
                },
                onSelected: (int index) {
                  setState(() {
                    selected = index;
                  });
                },
              ),
            ),
          ],
          innerDistance: MediaQuery.of(context).size.width > 400 ? 80 : 30,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget getCalendarBody() {
    switch (selected) {
      case 0:
        return Container();
      case 1:
        return Container();
      case 2:
        return Week();
      case 3:
        return Month();
    }
    return Text('Error: wrong body: $selected', style: TextStyle(color: Colors.red, fontSize: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: _appBar(),
      drawer: _menu(),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 0.0),
        child: getCalendarBody(),
      ),
      floatingActionButton: _buildNavigation(),
    );
  }
}
