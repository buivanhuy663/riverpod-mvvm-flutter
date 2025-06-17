import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../utilities/extensions/extensions.dart';
import '../../resources/resources.dart';

part 'password_entity.freezed.dart';

@freezed
sealed class PasswordEntity with _$PasswordEntity {
  const factory PasswordEntity(String? value) = _PasswordEntity;

  const PasswordEntity._();

  factory PasswordEntity.create(String value) => PasswordEntity(value);

  factory PasswordEntity.pure() => const PasswordEntity(null);

  bool get valid => _isPassword();

  String? get errorText {
    if (value == null || _isPassword()) {
      return null;
    } else if (value.isNullOrEmpty) {
      return AppText.get?.password_required;
    } else {
      return AppText.get?.password_invalid;
    }
  }

  bool _isPassword() => (value ?? '').length >= 8;
}
