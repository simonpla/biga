import '../../calendar/UI/calendar.dart';
import 'package:flutter/material.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'popuptask.dart';
import '../../Theme/themes.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> with TickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  int selected = 3;

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
                  color: primaryColorL,
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
                        icon: menuIcon,
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
                        icon: searchIcon,
                        onPressed: () => null,
                      ),
                    ),
                  ],
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  showDialog(context: context, builder: (_) => NewTaskPopup());
                },
                child: plusIcon,
                backgroundColor: buttonColor,
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
            ListTile(
              leading: Container(
                child: taskIcon,
              ),
              title: Text('Tasks', style: TextStyle(color: uTextColor)),
              onTap: () => Navigator.pushNamed(context, '/tasks'),
              hoverColor: hoverColorL,
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

  PreferredSizeWidget _appBar() {
    List<String> items = [
      'appointments',
      'day',
      'week',
      'month'
    ]; //TODO: consider replacing appointments with schedule

    return AppBar(
      backgroundColor: accentColor,
      elevation: 0,
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
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                      color: iconColor,
                      icon: starIcon,
                      onPressed: () => null,
                    ),
                  )
                : null,
            MediaQuery.of(context).size.width > 670
                ? Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                      color: iconColor,
                      icon: starIcon,
                      onPressed: () => null,
                    ),
                  )
                : null,
            MediaQuery.of(context).size.width > 550
                ? Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                      color: iconColor,
                      icon: starIcon,
                      onPressed: () => null,
                    ),
                  )
                : null,
            MediaQuery.of(context).size.width > 300
                ? Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    child: IconButton(
                      color: iconColor,
                      icon: starIcon,
                      onPressed: () => null,
                    ),
                  )
                : null,
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: IconButton(
                color: iconColor,
                icon: starIcon,
                onPressed: () => null,
              ),
            ),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: PopupMenuButton<int>(
                offset: Offset(60, 30),
                color: menuBackgroundL,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                child: Center(child: calendarIcon),
                itemBuilder: (context) {
                  return List.generate(4, (index) {
                    return PopupMenuItem(
                      child: Row(
                        children: [
                          Icon(iconsMenuChooseCalendarLayout[index],
                              color: iconColor),
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
    return Text('Error: wrong body: $selected',
        style: TextStyle(color: errorColor, fontSize: 30));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: _appBar(),
      drawer: _menu(),
      body: Padding(
        padding: EdgeInsets.only(top: 20.0, bottom: 0.0),
        child: Container(
          color: uBackground,
          child: getCalendarBody(),
        ),
      ),
      floatingActionButton: _buildNavigation(),
    );
  }
}

