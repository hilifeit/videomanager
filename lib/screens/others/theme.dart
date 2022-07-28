import 'package:videomanager/screens/others/exporter.dart';

var lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(primary: primaryColor),
    toggleableActiveColor: primaryColor,
    textSelectionTheme: TextSelectionThemeData(cursorColor: primaryColor),
    inputDecorationTheme: InputDecorationTheme(
      focusColor: primaryColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: Color(0xffD1D1D1), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: Color(0xffD1D1D1), width: 1),
      ),
    ));
