part of './extensions.dart';

extension BuildContextEx on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;

  bool get isMobile => screenSize.width < ResponsiveBoundary.minTablet;

  bool get isTablet =>
      screenSize.width >= ResponsiveBoundary.minTablet &&
      screenSize.width < ResponsiveBoundary.minDesktop;

  bool get isDesktop => screenSize.width >= ResponsiveBoundary.minDesktop;

  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;
}
