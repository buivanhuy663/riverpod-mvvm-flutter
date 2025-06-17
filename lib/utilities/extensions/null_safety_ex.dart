part of './extensions.dart';

extension NullSafetyEx<T> on T {
  R safe<R>(R Function(T it) func) => func(this);
}
