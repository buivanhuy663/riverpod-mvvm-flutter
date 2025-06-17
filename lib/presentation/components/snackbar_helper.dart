import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String? message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message.toString()),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

void showInfoSnackBar(BuildContext context, String? message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message.toString()),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
