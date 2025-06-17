part of 'resources.dart';

class AppText {
  AppText._();

  static AppLocalizations? get get {
    final ctx = navigatorKey.currentContext;
    return ctx != null ? AppLocalizations.of(ctx) : null;
  }
}
