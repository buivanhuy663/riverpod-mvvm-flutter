import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main/app_flavor.dart';
import '../main/dependence.dart';
import 'base/app_lifecycle.dart';
import 'base/go_router.dart';
import 'base/responsive_wrapper.dart';
import 'base/locale_support.dart';
import 'base/theme_support.dart';
import 'resources/app_theme.dart';
import 'resources/strings/app_localizations.dart';

class App extends StatefulWidget {
  const App({required this.appFlavor, super.key});

  final AppFlavor appFlavor;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App>
    with WidgetsBindingObserver, AppLifecycleMixin {
  final _appLifecycle = injector.read(appLifecycleProvider);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _appLifecycle.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _appLifecycle.addAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) => Consumer(
    builder: (context, ref, child) => MaterialApp.router(
      routerConfig: goRouter,
      locale: ref.watch(localeProvider),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: SupportLocale.support,
      theme: ThemeData(
        brightness: ref.watch(themeProvider),
        scaffoldBackgroundColor: colors.background,
      ),
      builder: (context, widget) => getResponsiveWrapper(context, widget),
    ),
  );
}
