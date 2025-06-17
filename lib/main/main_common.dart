import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view/app.dart';
import '../utilities/helpers/logger_helper.dart';
import 'app_flavor.dart';
import 'dependence.dart';

void mainCommon(AppFlavor appFlavor) {
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      final container = await Dependence.initDependence(appFlavor);
      runApp(
        UncontrolledProviderScope(
          container: container,
          child: App(appFlavor: appFlavor),
        ),
      );
    },
    (error, stackTrace) {
      LoggerHelper.error('$error', stackTrace: stackTrace);
    },
  );
}
