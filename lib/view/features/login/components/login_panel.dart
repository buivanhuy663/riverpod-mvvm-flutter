import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/base_page.dart';
import '../../../base/components/custom_text_form_field.dart';
import '../../../resources/resources.dart';
import '../view_model/login_state.dart';
import '../view_model/login_view_model.dart';

class LoginPanel extends StatelessWidget {
  const LoginPanel({
    required this.provider,
    required this.onPressLogin,
    super.key,
  });

  final ViewModelProvider<LoginViewModel, LoginState> provider;
  final Function() onPressLogin;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Consumer(
        builder: (context, ref, child) => CustomTextFormField(
          hintText: AppText.of(context)?.enter_email,
          labelText: AppText.of(context)?.email,
          keyboardType: TextInputType.emailAddress,
          errorText: provider.listen(ref, (value) => value.email.errorText(context)),
          onChanged: provider.viewModel(ref).onEmailChanged,
        ),
      ),
      const SizedBox(height: 8),
      Consumer(
        builder: (context, ref, child) => CustomTextFormField(
          hintText: AppText.of(context)?.enter_password,
          labelText: AppText.of(context)?.password,
          keyboardType: TextInputType.text,
          errorText: provider.listen(ref, (value) => value.password.errorText(context)),
          onChanged: provider.viewModel(ref).onPasswordChanged,
        ),
      ),
      const SizedBox(height: 16),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressLogin,
          child: Text(AppText.of(context)?.login_button ?? 'login_button'),
        ),
      ),
    ],
  );
}
