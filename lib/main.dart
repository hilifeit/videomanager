import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:videomanager/screens/viewscreen/viewscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // todo: asdsad
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1920, 1080),
      builder: (_, child) {
        return ProviderScope(
          child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Demo',
              themeMode: ThemeMode.light,
              darkTheme: ThemeData(brightness: Brightness.dark),
              theme: ThemeData(
                brightness: Brightness.light,
                primarySwatch: Colors.blue,
              ),
              home: ViewScreen()),
        );
      },
    );
  }
}
