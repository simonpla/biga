import 'package:flutter/foundation.dart';
import 'pages/UI/tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'dart:io';
import '../../Theme/themes.dart';

void main() {
  setColorsTry();
  setIconsTry();
  try {
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
        '/chat': (context) => Container(),
        '/notes': (context) => Container(),
        '/contacts': (context) => Container(),
        '/settings': (context) => Container(),
      },
    );
  }
}

