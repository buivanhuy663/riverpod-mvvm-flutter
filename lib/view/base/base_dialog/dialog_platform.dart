import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../resources/resources.dart';
import 'base_dialog.dart';

enum TypeDialog { alert, confirm }

enum ActionDialog { cancel, ok }

class DialogPlatform extends BaseDialog<ActionDialog> {
  DialogPlatform({
    required this.content,
    this.title,
    this.type = TypeDialog.alert,
    this.btnOK = '',
    this.btnCancel = '',
    this.contentPadding = const EdgeInsets.only(top: 20, bottom: 20),
  }) : assert(content != null),
       assert(
         content is Widget || content is String,
         'Param content must be of type Widget or String',
       );

  final String? title;
  final dynamic content;
  final TypeDialog type;
  String btnOK, btnCancel;
  final EdgeInsets contentPadding;

  @override
  ActionDialog? onDismissDialog() => ActionDialog.cancel;

  @override
  Widget build(BuildContext context) {
    btnCancel = btnCancel.isEmpty ? AppText.of(context)?.cancel_button_dialog ?? 'Null' : '';
    btnOK = btnOK.isEmpty ? AppText.of(context)?.ok_button_dialog ?? 'Null' : btnOK;

    return defaultTargetPlatform == TargetPlatform.android || kIsWeb
        ? _androidPlatform(context)
        : _iosPlatform(context);
  }

  CupertinoAlertDialog _iosPlatform(BuildContext context) => CupertinoAlertDialog(
    title: title == null ? null : Text(title ?? '', textAlign: TextAlign.center),
    content: Padding(
      padding: contentPadding,
      child: content is String ? Text(content) : content,
    ),
    actions: <Widget>[
      if (type == TypeDialog.confirm)
        _cupertinoButtonCustom(
          context,
          txtButton: btnCancel,
          response: ActionDialog.cancel,
        ),
      _cupertinoButtonCustom(
        context,
        txtButton: btnOK,
        response: ActionDialog.ok,
      ),
    ],
  );

  AlertDialog _androidPlatform(BuildContext context) => AlertDialog(
    title: title == null ? null : Text(title ?? '', textAlign: TextAlign.center),
    content: Padding(
      padding: contentPadding,
      child: content is String ? Text(content) : content,
    ),
    actions: <Widget>[
      if (type == TypeDialog.confirm)
        _materialButtonCustom(
          context,
          txtButton: btnCancel,
          response: ActionDialog.cancel,
        ),
      _materialButtonCustom(
        context,
        txtButton: btnOK,
        response: ActionDialog.ok,
      ),
    ],
  );

  Widget _materialButtonCustom(
    context, {
    required String txtButton,
    required ActionDialog response,
  }) => TextButton(
    onPressed: () => dismiss(result: response),
    child: Text(txtButton, style: const TextStyle(fontSize: 17)),
  );

  Widget _cupertinoButtonCustom(
    context, {
    required String txtButton,
    required ActionDialog response,
  }) => CupertinoDialogAction(
    onPressed: () => dismiss(result: response),
    child: Text(txtButton, style: const TextStyle(fontSize: 17)),
  );
}
