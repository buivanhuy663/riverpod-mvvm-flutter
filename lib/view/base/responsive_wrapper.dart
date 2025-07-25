import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';

/// Resource: https://pub.dev/packages/responsive_framework

Widget getResponsiveWrapper(BuildContext context, Widget? widget) {
  if (widget != null) {
    return ResponsiveBreakpoints.builder(
      child: widget,
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
    );
  } else {
    return Container(color: Colors.white, child: const Text('widget is null'));
  }
}
