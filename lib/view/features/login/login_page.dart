import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/extensions/extensions.dart';
import '../../base/base_page.dart';
import '../../base/locale_support.dart';
import '../../resources/resources.dart';
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
          EmailFormField(provider: _provider),
          const SizedBox(height: 8),
          PasswordFormField(provider: _provider),
          const SizedBox(height: 16),
          LoginButton(
            provider: _provider,
            onPressed: () {
              viewModel
                  .onPressLogin(ref)
                  .subscribeLoadingFullScreen(this)
                  .subscribeHandleError(this);
            },
          ),
          const SizedBox(height: 16),
          Text(
            AppText.of(context)?.language ?? '',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.of(context).text,
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                child: Text(AppText.of(context)?.language_english ?? ''),
                onPressed: () {
                  viewModel.onChangeLanguage(ref, SupportLocale.en);
                },
              ),

              ElevatedButton(
                child: Text(AppText.of(context)?.language_vietnam ?? ''),
                onPressed: () {
                  viewModel.onChangeLanguage(ref, SupportLocale.vn);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            AppText.of(context)?.theme_mode ?? '',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.of(context).text,
            ),
          ),
          Row(
            children: [
              ElevatedButton(
                child: Text(AppText.of(context)?.dark_mode ?? ''),
                onPressed: () {
                  viewModel.onChangeThemeMode(ref, Brightness.dark);
                },
              ),

              ElevatedButton(
                child: Text(AppText.of(context)?.light_mode ?? ''),
                onPressed: () {
                  viewModel.onChangeThemeMode(ref, Brightness.light);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    ),
  );
}
