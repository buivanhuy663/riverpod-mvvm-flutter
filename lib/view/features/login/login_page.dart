import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/extensions/extensions.dart';
import '../../base/base_page.dart';
import '../../base/components/custom_text_form_field.dart';
import '../../base/locale_support.dart';
import '../../resources/resources.dart';
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
          Consumer(
            builder: (context, ref, child) => CustomTextFormField(
              hintText: AppText.of(context)?.enter_email,
              labelText: AppText.of(context)?.email,
              keyboardType: TextInputType.emailAddress,
              errorText: _provider.listen(ref, (value) => value.email.errorText(context)),
              onChanged: _provider.viewModel(ref).onEmailChanged,
            ),
          ),
          const SizedBox(height: 8),
          Consumer(
            builder: (context, ref, child) => CustomTextFormField(
              hintText: AppText.of(context)?.enter_password,
              labelText: AppText.of(context)?.password,
              keyboardType: TextInputType.text,
              errorText: _provider.listen(ref, (value) => value.password.errorText(context)),
              onChanged: _provider.viewModel(ref).onPasswordChanged,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Text(AppText.of(context)?.login_button ?? 'login_button'),
              onPressed: () {
                viewModel
                    .onPressLogin(ref)
                    .subscribeLoadingFullScreen(this)
                    .subscribeHandleError(this);
              },
            ),
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
