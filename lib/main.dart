import 'package:aufgabenplaner/database/database.dart';
import 'package:aufgabenplaner/pages/chat/chat.dart';
import 'package:aufgabenplaner/pages/contacts/contacts.dart';
import 'package:aufgabenplaner/pages/notes/notes.dart';
import 'package:aufgabenplaner/pages/tasks/timeline/timeline.dart';

import 'pages/tasks/tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'dart:io';
import '../../Theme/themes.dart';

final setStateNeeded = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
]; // 0 is popuptask, 1 contactpopup, 2 contacts, 3 chat, 4 tasks page 5 notes 6 timeline



void main() {
  setColorsTry();
  setIconsTry();
  try {
    //set minimum window size on desktop to avoid render overflows when the window is unreasonably small
    WidgetsFlutterBinding.ensureInitialized();
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowTitle('biga');
      setWindowMinSize(const Size(600, 550));
      setWindowMaxSize(Size.infinite);
    }
  } catch (e) {
    print('setting minimum window size not possible');
  }

  dbSetup();

  runApp(Biga());
}

class Biga extends StatelessWidget {
  const Biga({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'biga',
      initialRoute: '/kanban',
      routes: {
        '/kanban': (context) => TasksPage(),
        '/timeline': (context) => Timeline(),
        '/chat': (context) => ChatPage(),
        '/notes': (context) => Notes(),
        '/contacts': (context) => Contacts(),
        '/settings': (context) => Container(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
