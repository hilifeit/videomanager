import 'package:videomanager/screens/holder/holder.dart';
import 'package:videomanager/screens/others/exporter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  storage.erase();
  // window.document.onContextMenu.listen((evt) => evt.preventDefault());
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
              theme: lightTheme,
              home: Holder()),
        );
      },
    );
  }
}
