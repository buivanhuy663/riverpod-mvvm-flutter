part of './extensions.dart';

extension StringExNullable on String? {
  // ignore: force_null_safety
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNullOrBlank =>
      this == null || this!.isEmpty || this!.trim().isEmpty;

  // ignore: force_null_safety
  bool get isNotNullOrEmpty => this == null || this!.isNotEmpty;
}

extension StringEx on String {
  bool get isNotNullOrBlank =>
      this != 'null' && isNotEmpty && trim().isNotEmpty;
}
