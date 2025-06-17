import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../entities/account/email_entity.dart';
import '../../../entities/account/password_entity.dart';

part 'login_state.freezed.dart';

@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState({
    required EmailEntity email,
    required PasswordEntity password,
    required bool isValidButton,
  }) = _LoginState;

  const LoginState._();

  factory LoginState.initial() => LoginState(
    email: EmailEntity.pure(),
    password: PasswordEntity.pure(),
    isValidButton: false,
  );
}
