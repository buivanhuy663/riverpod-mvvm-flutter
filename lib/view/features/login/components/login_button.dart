import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/base_page.dart';
import '../../../resources/resources.dart';
import '../view_model/login_state.dart';
import '../view_model/login_view_model.dart';

class LoginButton extends ConsumerWidget {
  const LoginButton({
    required this.provider,
    required this.onPressed,
    super.key,
  });

  final ViewModelProvider<LoginViewModel, LoginState> provider;

  final Function() onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) => SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      onPressed: onPressed,
      child: Text(AppText.of(context)?.login_button ?? 'Null Login Button'),
    ),
  );
}
