import 'package:flutter/material.dart';

import '../../../utils/helpers/logger_helper.dart';

mixin BasePageMixin {
  /// This function is called when the start page state is initialized.
  /// Can't get context here
  @mustCallSuper
  void onInitState() {
    LoggerHelper.info('[Page][$pageName] is initializing state');
  }

  /// This function is called when the page state has been created.
  /// The context can be obtained here
  @mustCallSuper
  void onStateCreated(BuildContext context) {
    LoggerHelper.info('[Page][$pageName] is created state');
  }

  /// This function is called when this page is re-rendered on the screen
  /// (Instance reappears after being completely covered by another page
  /// or newly created).
  ///
  /// In case of page transition effect,
  /// the modal is called when the actual page transition is finished
  @mustCallSuper
  void onAppearedPage() {
    LoggerHelper.info('[Page][$pageName] is appeared');
  }

  /// This function is called when this page disappears from the screen
  /// (In case it is completely covered by another page or page is disposed).
  ///
  /// In case of page transition effect,
  /// the modal is called when the actual page transition is finished
  @mustCallSuper
  void onDisappearedPage() {
    LoggerHelper.info('[Page][$pageName] is disappeared');
  }

  /// This function is called when the page is actually disposed
  @mustCallSuper
  void onDispose() {
    LoggerHelper.info('[Page][$pageName] is disposing ');
  }

  @mustCallSuper
  void onRefreshPage() {
    LoggerHelper.info('[Page][$pageName] reloading');
  }

  /// When this function is overridden.
  /// It will be called when a pop command is called on the navigator.
  PopInvokedWithResultCallback? onPopWithResult() => null;

  bool get resizeToAvoidBottomInset => false;

  /// If this property is `true`
  /// then it will allow tap outside the screen to hide the keyboard
  bool get tapOutsideHideKeyBoard => false;

  /// This is page background color
  Color? get backgroundColor => null;

  /// If this property is `true`
  /// then it will wrap this page by the `SafeArea` Widget
  bool get hasUseSafeArea => false;

  String get pageName => (this as State).widget.runtimeType.toString();
}
