import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider =
    StateNotifierProvider.autoDispose<ThemeSupport, Brightness>(
      (ref) => ThemeSupport(),
    );

class ThemeSupport extends StateNotifier<Brightness> {
  ThemeSupport({@visibleForTesting Brightness? brightness})
    : super(brightness ?? Brightness.light);

  void setBrightness(Brightness brightness) {
    state = brightness;
  }

  void clearBrightness() {
    state = Brightness.light;
  }
}
