import 'package:flutter/foundation.dart';
import 'pages/UI/tasks_page.dart';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart';
import 'dart:io';
import '../../Theme/themes.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://424162517de748babee6e1b3c418596b@o1088201.ingest.sentry.io/6102840';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(Biga()),
  );
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

