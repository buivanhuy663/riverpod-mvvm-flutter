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
          hintText: context.strings.enter_email,
          labelText: context.strings.email,
          keyboardType: TextInputType.emailAddress,
          errorText: provider.listen(ref, (value) => value.email.errorText(context)),
          onChanged: provider.viewModel(ref).onEmailChanged,
        ),
      ),
      const SizedBox(height: 8),
      Consumer(
        builder: (context, ref, child) => CustomTextFormField(
          hintText: context.strings.enter_password,
          labelText: context.strings.password,
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
          child: Text(context.strings.login_button),
        ),
      ),
    ],
  );
}
