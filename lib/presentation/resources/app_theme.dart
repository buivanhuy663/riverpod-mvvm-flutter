import 'package:flutter/material.dart';

import 'resources.dart';

ThemeData getAppTheme(Brightness brightness) {
  final colors = brightness == Brightness.light
      ? ColorsDefine.colorsLight
      : ColorsDefine.colorsDark;

  return ThemeData(
    brightness: brightness,
    scaffoldBackgroundColor: colors.background,
  );
}
