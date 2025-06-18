part of 'resources.dart';

class _ImagePath {
  static const String _root = 'assets/images';
  static const String flutter = '$_root/flutter.png';
}

class AppImages extends StatelessWidget {
  const AppImages({
    required this.path,
    super.key,
    this.width,
    this.height,
  });

  final String path;
  final double? width;
  final double? height;
  @override
  Widget build(BuildContext context) => Image.asset(
    path,
    width: width ?? 100,
    height: height ?? 100,
  );

  AppImages copyWith({double? width, double? height}) => AppImages(
    path: path,
    width: width ?? this.width,
    height: height ?? this.height,
  );

  /// Image define.
  static const flutter = AppImages(path: _ImagePath.flutter);
}
