import 'package:aufgabenplaner/pages/chat/chat.dart';
import 'package:aufgabenplaner/pages/contacts/contacts.dart';
import 'package:aufgabenplaner/pages/notes/notes.dart';

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
]; // 0 is popuptask, 1 contactpopup, 2 contacts, 3 chat, 4 tasks page 5 notes

void main() {
  setColorsTry();
  setIconsTry();
  try {
    //set minimum window size on desktop to avoid render overflows when the window is unreasonably small
    WidgetsFlutterBinding.ensureInitialized();
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowTitle('biga');
      setWindowMinSize(const Size(400, 550));
      setWindowMaxSize(Size.infinite);
    }
  } catch (e) {
    print('setting minimum window size not possible');
  }
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
      initialRoute: '/tasks',
      routes: {
        '/tasks': (context) => TasksPage(),
        '/chat': (context) => ChatPage(),
        '/notes': (context) => Notes(),
        '/contacts': (context) => Contacts(),
        '/settings': (context) => Container(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
