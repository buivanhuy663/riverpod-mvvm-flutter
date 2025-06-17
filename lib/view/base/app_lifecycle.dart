import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main/dependence.dart';
import '../../utilities/helpers/logger_helper.dart';

final appLifecycleProvider = Provider<AppLifecycle>(
  (ref) => throw UnimplementedError(),
);

class AppLifecycle {
  AppLifecycle();

  final _appLifeCycleState = StreamController<AppLifecycleState>.broadcast();

  Stream<AppLifecycleState> get appLifeCycleState => _appLifeCycleState.stream;

  void addAppLifecycleState(AppLifecycleState appLifecycleState) {
    _appLifeCycleState.add(appLifecycleState);
  }

  void close() {
    _appLifeCycleState.close();
  }
}

mixin AppLifecycleMixin<T extends StatefulWidget> on State<T> {
  late StreamSubscription<AppLifecycleState> _appLifecycleState;

  @override
  void initState() {
    super.initState();
    _appLifecycleState = injector
        .read(appLifecycleProvider)
        .appLifeCycleState
        .asBroadcastStream()
        .listen((state) {
          switch (state) {
            case AppLifecycleState.inactive:
              onInactive();
              break;
            case AppLifecycleState.paused:
              onPaused();
              break;
            case AppLifecycleState.resumed:
              onResumed();
              break;
            case AppLifecycleState.detached:
              onDetached();
              break;
            case AppLifecycleState.hidden:
              hidden();
              break;
          }
        });
  }

  @override
  void dispose() {
    _appLifecycleState.cancel();
    super.dispose();
  }

  @mustCallSuper
  void onInactive() {
    LoggerHelper.info('[Lifecycle][${widget.runtimeType}] onInactive');
  }

  @mustCallSuper
  void onPaused() {
    LoggerHelper.info('[Lifecycle][${widget.runtimeType}] onPaused');
  }

  @mustCallSuper
  void onResumed() {
    LoggerHelper.info('[Lifecycle][${widget.runtimeType}] onResumed');
  }

  @mustCallSuper
  void onDetached() {
    LoggerHelper.info('[Lifecycle][${widget.runtimeType}] onDetached');
  }

  @mustCallSuper
  void hidden() {
    LoggerHelper.info('[Lifecycle][${widget.runtimeType}] hidden');
  }
}
