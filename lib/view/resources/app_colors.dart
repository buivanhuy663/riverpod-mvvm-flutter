part of 'resources.dart';

class ColorsDefine {
  const ColorsDefine({
    required this.blueMain,
    required this.background,
    required this.text,
    required this.textLighter,
    required this.primary,
  });

  final Color blueMain;
  final Color background;
  final Color text;
  final Color textLighter;
  final Color primary;

  static const colorsLight = ColorsDefine(
    blueMain: Colors.blue,
    background: Colors.white,
    text: Colors.black,
    textLighter: Color(0xFF637180),
    primary: Color(0xFF056EDB),
  );

  static const colorsDark = ColorsDefine(
    blueMain: Colors.blue,
    background: Colors.black54,
    text: Colors.white,
    textLighter: Color(0xFF637180),
    primary: Color(0xFF056EDB),
  );
}
