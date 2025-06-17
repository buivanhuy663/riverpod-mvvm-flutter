import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/helpers/logger_helper.dart';
import '../view/app.dart';
import 'app_flavor.dart';
import 'dependence.dart';

void mainCommon(AppFlavor appFlavor) {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      injector = await Dependence.initDependence(appFlavor);
      runApp(
        UncontrolledProviderScope(
          container: injector,
          child: App(appFlavor: appFlavor),
        ),
      );
    },
    (error, stackTrace) {
      LoggerHelper.error('$error', stackTrace: stackTrace);
    },
  );
}
