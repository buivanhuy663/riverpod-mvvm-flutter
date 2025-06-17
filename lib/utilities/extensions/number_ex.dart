part of './extensions.dart';

extension NumberEx on num {
  double screenUtil(
    BuildContext context, {
    required double tablet,
    double? desktop,
  }) {
    if (desktop != null && context.isDesktop) {
      return desktop;
    } else if (context.isTablet) {
      return tablet;
    }
    return toDouble();
  }
}

extension NumberNullEx on num? {
  bool? get toBool => this != null && this != 0;
}
