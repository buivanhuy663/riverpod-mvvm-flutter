import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'strings/app_localizations.dart';
import 'strings/app_localizations_en.dart';

part 'app_colors.dart';
part 'app_images.dart';
part 'app_svg.dart';

extension BuildContextResource on BuildContext {
  AppLocalizations get strings => AppLocalizations.of(this) ?? AppLocalizationsEn();

  ColorsDefine get colors {
    switch (Theme.of(this).brightness) {
      case Brightness.light:
        return ColorsDefine.colorsLight;
      case Brightness.dark:
        return ColorsDefine.colorsDark;
    }
  }
}
