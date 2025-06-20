import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../data/models/auth/login_response_model.dart';
import '../../../base/base_page.dart';
import '../../../base/locale_support.dart';
import '../../../base/theme_support.dart';
import '../../../entities/account/email_entity.dart';
import '../../../entities/account/password_entity.dart';
import 'login_state.dart';

class LoginViewModel extends BaseViewModel<LoginState> {
  LoginViewModel() : super(LoginState.initial());

  void onEmailChanged(String value) {
    state = state.copyWith(email: EmailEntity.create(value));
    _checkValidButton();
  }

  void onPasswordChanged(String value) {
    state = state.copyWith(password: PasswordEntity.create(value));
    _checkValidButton();
  }

  void _checkValidButton() {
    state = state.copyWith(
      isValidButton: state.email.valid && state.password.valid,
    );
  }

  void onChangeThemeMode(WidgetRef ref, Brightness mode) {
    themeProvider.viewModel(ref).setBrightness(mode);
  }

  void onChangeLanguage(WidgetRef ref, Locale lang) {
    localeProvider.viewModel(ref).setLocale(lang);
  }

  Future<LoginResponseModel?> onPressLogin(WidgetRef ref) async {
    await Future.delayed(const Duration(seconds: 3));
    return null;
  }
}
