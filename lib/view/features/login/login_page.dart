import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/extensions/extensions.dart';
import '../../base/base_page.dart';
import '../../base/locale_support.dart';
import '../../resources/resources.dart';
import 'components/login_panel.dart';
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
  LoginViewModel get viewModel => _provider.viewModel(ref);

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @override
  Widget buildBody(BuildContext context) => SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 64),
          AppImages.flutter,
          const SizedBox(height: 16),
          LoginPanel(
            provider: _provider,
            onPressLogin: onPressLogin,
          ),
          const SizedBox(height: 16),
          Text(
            context.strings.language,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: context.colors.text,
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                child: Text(context.strings.language_english),
                onPressed: () => viewModel.onChangeLanguage(ref, SupportLocale.en),
              ),
              ElevatedButton(
                child: Text(context.strings.language_vietnam),
                onPressed: () => viewModel.onChangeLanguage(ref, SupportLocale.vn),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            context.strings.theme_mode,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: context.colors.text,
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                child: Text(context.strings.dark_mode),
                onPressed: () => viewModel.onChangeThemeMode(ref, Brightness.dark),
              ),

              ElevatedButton(
                child: Text(context.strings.light_mode),
                onPressed: () => viewModel.onChangeThemeMode(ref, Brightness.light),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );

  void onPressLogin() {
    _provider
        .viewModel(ref)
        .onPressLogin(ref)
        .subscribeLoadingFullScreen(this)
        .subscribeHandleError(this);
  }
}
