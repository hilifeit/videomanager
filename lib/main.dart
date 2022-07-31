// ignore: avoid_web_libraries_in_flutter
import 'dart:html'
    if (dart.library.io) "package:videomanager/screens/others/fakeClasses.dart"
    show window;

import 'package:flutter/foundation.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:videomanager/screens/load.dart';
import 'package:videomanager/screens/others/exporter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    await DartVLC.initialize();
  } else {
    window.document.onContextMenu.listen((evt) => evt.preventDefault());
  }
  await GetStorage.init();
  // storage.erase();

  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // return LayoutBuilder(builder: (context, constraints) {

    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo',
        themeMode: ThemeMode.light,
        darkTheme: ThemeData(brightness: Brightness.dark),
        theme: lightTheme,
        home: const Loader(),

        // home: const Scaffold(body: Loader())
      ),
    );

    // });
  }
}
