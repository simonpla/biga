import 'package:flutter/foundation.dart';
import 'pages/UI/tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'dart:io';

void main() {
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

final ThemeData kIOSTheme = ThemeData(
  primarySwatch: Colors.cyan,
  primaryColor: Colors.teal,
  primaryColorBrightness: Brightness.light,
  accentColor: Colors.grey,
);

final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.cyan,
  primaryColor: Colors.teal,
  accentColor: Colors.grey,
);

class Biga extends StatelessWidget {
  const Biga({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'biga',
      theme: defaultTargetPlatform == TargetPlatform.iOS
          ? kIOSTheme
          : kDefaultTheme,
      home: TasksPage(),
    );
  }
}

