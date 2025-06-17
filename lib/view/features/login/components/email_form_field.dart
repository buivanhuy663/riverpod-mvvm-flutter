import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utilities/helpers/logger_helper.dart';
import '../../../components/custom_text_form_field.dart';
import '../../../resources/resources.dart';
import '../view_model/login_state.dart';
import '../view_model/login_view_model.dart';

class EmailFormField extends ConsumerWidget {
  const EmailFormField({required this.provider, super.key});

  final AutoDisposeStateNotifierProvider<LoginViewModel, LoginState> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LoggerHelper.info('EmailFormField');
    return CustomTextFormField(
      hintText: AppText.get?.enter_email,
      labelText: AppText.get?.email,
      keyboardType: TextInputType.emailAddress,
      errorText: ref.watch(provider.select((value) => value.email)).errorText,
      onChanged: ref.read(provider.notifier).onEmailChanged,
    );
  }
}
