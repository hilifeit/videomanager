import 'package:flutter/material.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;

var lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: const Color(0xff40667D),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: Color(0xffD1D1D1), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(color: Color(0xffD1D1D1), width: 1),
      ),
    ));

var fluentTheme = fluent.ThemeData();
