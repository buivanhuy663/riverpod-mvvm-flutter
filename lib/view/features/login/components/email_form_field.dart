import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/helpers/logger_helper.dart';
import '../../../base/base_page.dart';
import '../../../base/components/custom_text_form_field.dart';
import '../../../resources/resources.dart';
import '../view_model/login_state.dart';
import '../view_model/login_view_model.dart';

class EmailFormField extends ConsumerWidget {
  const EmailFormField({required this.provider, super.key});

  final ViewModelProvider<LoginViewModel, LoginState> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LoggerHelper.info('EmailFormField');
    return CustomTextFormField(
      hintText: AppText.of(context)?.enter_email,
      labelText: AppText.of(context)?.email,
      keyboardType: TextInputType.emailAddress,
      errorText: provider.listen(ref, (value) => value.email.errorText(context)),
      onChanged: provider.viewModel(ref).onEmailChanged,
    );
  }
}
