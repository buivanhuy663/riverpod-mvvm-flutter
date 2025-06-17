import 'package:flutter/material.dart';

import '../../../utilities/extensions/extensions.dart';

/// Every dialog needs to inherit from [BaseDialog].
///
/// [R] is the return result of dialog.
abstract class BaseDialog<R> {
  BaseDialog({this.key});

  final Key? key;

  BuildContext? _context;
  R? _result;

  double? elevation;
  Color? backgroundColor;

  /// Override this method with a widget to build ui for dialog
  Widget build(BuildContext context);

  /// Dialog will be shown on the screen when calling show() function
  Future<R?> show(
    BuildContext context, {
    bool isDismissible = true,
    PopInvokedWithResultCallback<dynamic>? result,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: isDismissible,
      builder: (contextDialog) {
        _context = contextDialog;
        return PopScope(
          onPopInvokedWithResult: (d, r) => result,
          child: Dialog(
            elevation: elevation,
            backgroundColor: backgroundColor,
            child: build(context),
          ),
        );
      },
    );
    final onDismissResult = onDismissDialog();
    onDismissResult?.safe((it) {
      _result = _result ?? onDismissResult;
    });

    return _result;
  }

  /// Dialog will close when calling dismiss() function.
  /// The return [result] can be passed to this method
  void dismiss({R? result}) {
    _result = result;
    _context?.safe((it) {
      Navigator.of(it).pop(_result);
    });
  }

  /// Overriding this method allows to execute an action when we call
  /// [dismiss]. If the [dismiss] function is called without passing a return,
  /// the default return of the show function will be the return
  /// value of [onDismissDialog].
  /// Otherwise, the return result of the [show] function will be null
  R? onDismissDialog() => null;
}
