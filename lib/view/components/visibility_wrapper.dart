import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VisibilityWrapper extends StatefulWidget {
  const VisibilityWrapper({
    required this.child,
    this.onAppeared,
    this.onDisappeared,
    super.key,
  });

  final Widget child;
  final Function()? onAppeared;
  final Function()? onDisappeared;

  @override
  State<VisibilityWrapper> createState() => _VisibilityWrapperState();
}

class _VisibilityWrapperState extends State<VisibilityWrapper> {
  final _visibilityKey = GlobalKey();
  var _isVisible = false;

  @override
  Widget build(BuildContext context) => VisibilityDetector(
    key: widget.key ?? _visibilityKey,
    onVisibilityChanged: _onChangeVisibility,
    child: widget.child,
  );

  void _onChangeVisibility(VisibilityInfo info) {
    if (info.visibleFraction > 0.95 && !_isVisible) {
      _isVisible = true;
      widget.onAppeared?.call();
    }
    if (info.visibleFraction < 0.05 && _isVisible) {
      _isVisible = false;
      widget.onDisappeared?.call();
    }
  }
}
