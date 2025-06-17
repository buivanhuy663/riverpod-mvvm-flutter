import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressIndicatorPlatform extends StatelessWidget {
  const ProgressIndicatorPlatform({this.verticalPadding = 30, super.key});
  final double verticalPadding;

  @override
  Widget build(BuildContext context) => Align(
    alignment: Alignment.center,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding),
      child: Platform.isAndroid
          ? const CircularProgressIndicator()
          : const CupertinoActivityIndicator(),
    ),
  );
}
