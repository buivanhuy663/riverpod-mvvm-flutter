import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/helpers/logger_helper.dart';
import '../../../base/base_page.dart';
import '../../../base/components/custom_text_form_field.dart';
import '../../../resources/resources.dart';
import '../view_model/login_state.dart';
import '../view_model/login_view_model.dart';

class PasswordFormField extends ConsumerWidget {
  const PasswordFormField({required this.provider, super.key});

  final ViewModelProvider<LoginViewModel, LoginState> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LoggerHelper.info('PasswordFormField');
    return CustomTextFormField(
      hintText: AppText.get?.enter_password,
      labelText: AppText.get?.password,
      keyboardType: TextInputType.text,
      errorText: ref.watch(provider.select((value) => value.password)).errorText,
      onChanged: ref.read(provider.notifier).onPasswordChanged,
    );
  }
}
