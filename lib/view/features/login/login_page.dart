import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/extensions/extensions.dart';
import '../../base/base_page/base_page.dart';
import 'components/email_form_field.dart';
import 'components/login_button.dart';
import 'components/password_form_field.dart';
import 'view_model/login_state.dart';
import 'view_model/login_view_model.dart';

final _provider = StateNotifierProvider.autoDispose<LoginViewModel, LoginState>(
  (ref) => LoginViewModel(),
);

class LoginPage extends BasePage {
  const LoginPage({super.key});

  @override
  BasePageState<LoginPage, LoginViewModel> createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage, LoginViewModel> {
  @override
  LoginViewModel get viewModel => ref.read(_provider.notifier);

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @override
  Widget buildBody(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 64),
          EmailFormField(provider: _provider),
          const SizedBox(height: 8),
          PasswordFormField(provider: _provider),
          const SizedBox(height: 16),
          LoginButton(
            provider: _provider,
            onPressed: () {
              viewModel.onPressLogin(ref).subscribeLoadingFullScreen(this);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}
