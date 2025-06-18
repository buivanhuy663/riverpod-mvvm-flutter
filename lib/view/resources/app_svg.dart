part of 'resources.dart';

class _SvgPath {
  static const String _root = 'assets/svg_icons';
  static const String todoChecked = '$_root/todoChecked.svg';
}

class AppSvg extends StatelessWidget {
  const AppSvg({
    required this.path,
    super.key,
    this.width,
    this.height,
  });

  final String path;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    path,
    width: width ?? 100,
    height: height ?? 100,
    // colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
    // semanticsLabel: 'Red dash paths',
  );

  AppSvg copyWith({double? width, double? height}) => AppSvg(
    path: path,
    width: width ?? this.width,
    height: height ?? this.height,
  );

  /// SVG image.
  static const AppSvg todoChecked = AppSvg(
    path: _SvgPath.todoChecked,
  );
}
