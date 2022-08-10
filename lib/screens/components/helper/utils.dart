import 'dart:math' as math;
import 'dart:typed_data';

import 'package:random_color/random_color.dart';
import 'package:videomanager/screens/others/exporter.dart';
import 'package:videomanager/screens/screenshotmanager/screens/dashboard/screenshotdashboard/components/pixelColorPicker.dart';

int map(int x, int inMin, int inMax, int outMin, int outMax) {
  var calc =
      ((x - inMin) * (outMax - outMin) / (inMax - inMin) + outMin).toInt();
  if (calc > outMax) {
    return outMax;
  } else if (calc < outMin) {
    return outMin;
  } else {
    return calc;
  }
}

double mapDouble(
    {required double x,
    // ignore: non_constant_identifier_names
    required double in_min,
    // ignore: non_constant_identifier_names
    required double in_max,
    // ignore: non_constant_identifier_names
    required double out_min,
    // ignore: non_constant_identifier_names
    required double out_max}) {
  var calc = ((x - in_min) * (out_max - out_min) / (in_max - in_min) + out_min);
  if (calc > out_max) {
    return out_max;
  } else if (calc < out_min) {
    return out_min;
  } else {
    return calc;
  }
}

String intToTime(int value,
    {bool hour = false, bool min = true, bool sec = true}) {
  int h, m, s;

  h = value ~/ 3600;

  m = ((value - h * 3600)) ~/ 60;

  s = value - (h * 3600) - (m * 60);

  String hourLeft = h.toString().length < 2 ? "0$h" : h.toString();

  String minuteLeft = m.toString().length < 2 ? "0$m" : m.toString();

  String secondsLeft = s.toString().length < 2 ? "0$s" : s.toString();

  String result = "${hour ? "$hourLeft:" : ""}$minuteLeft:$secondsLeft";

  return result;
}

formatBytes(bytes, {int decimals = 2}) {
  if (bytes == 0) return '0 Bytes';
  const k = 1024;
  var dm = decimals < 0 ? 0 : decimals;
  const sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'];
  var i = (math.log(bytes) / math.log(k)).floor();
  return '${((bytes) / math.pow(k, i)).toStringAsFixed(dm)} ${sizes[i]}';
}

Future<Color> getColorFromImagePixel(
    {required Uint8List imageData, required Offset pixelPosition}) async {
  ColorPicker colorPicker = ColorPicker(bytes: imageData);
  Color color = await colorPicker.getColor(
    pixelPosition: pixelPosition,
  );
  if (color.computeLuminance() > 0.5) {
    color = RandomColor().randomColor(
        colorSaturation: ColorSaturation.highSaturation,
        colorBrightness: ColorBrightness.dark);
  } else {
    color = RandomColor().randomColor(
        colorSaturation: ColorSaturation.highSaturation,
        colorBrightness: ColorBrightness.light);
  }
  return color;
}
