import 'pages/UI/tasks_page.dart';
import 'pages/popuptask/popuptask.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'dart:io';
import '../../Theme/themes.dart';

void main() {
  setColorsTry();
  setIconsTry();
  try { //set minimum window size on desktop to avoid render overflows when the window is unreasonably small
    WidgetsFlutterBinding.ensureInitialized();
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      setWindowTitle('biga');
      setWindowMinSize(const Size(400, 550));
      setWindowMaxSize(Size.infinite);
    }
  } catch(e) {
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
        '/tasks/new': (context) => NewTaskPopup(),
        '/chat': (context) => Container(),
        '/notes': (context) => Container(),
        '/contacts': (context) => Container(),
        '/settings': (context) => Container(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

