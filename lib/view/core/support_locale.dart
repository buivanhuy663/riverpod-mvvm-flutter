import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider =
    StateNotifierProvider.autoDispose<LocaleProvider, Locale>(
      (ref) => LocaleProvider(),
    );

class LocaleProvider extends StateNotifier<Locale> {
  LocaleProvider({@visibleForTesting Locale? locale})
    : super(locale ?? const Locale('en'));

  void setLocale(Locale locale) {
    if (!SupportLocale.support.contains(locale)) {
      return;
    }
    state = locale;
  }

  void clearLocale() {
    state = SupportLocale.en;
  }
}

class SupportLocale {
  static const Locale en = Locale('en');
  static const Locale vn = Locale('vi');
  static const List<Locale> support = [Locale('en'), Locale('vi')];
}
