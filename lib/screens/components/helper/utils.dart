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
