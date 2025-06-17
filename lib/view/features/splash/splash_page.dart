import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../base/base_page/base_page.dart';
import '../../base/go_router.dart';
import 'splash_view_model.dart';

final _provider = StateNotifierProvider.autoDispose((ref) => SplashViewModel());

class SplashPage extends BasePage {
  const SplashPage({super.key});

  @override
  BasePageState<SplashPage, SplashViewModel> createState() =>
      _SplashViewState();
}

class _SplashViewState extends BasePageState<SplashPage, SplashViewModel> {
  @override
  SplashViewModel get viewModel => ref.read(_provider.notifier);

  @override
  void onInitState() {
    super.onInitState();

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        GoRouteHelper.go(context, RouterPath.login);
      }
    });
  }

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @override
  Widget buildBody(BuildContext context) => const Center(
    child: SizedBox(height: 100, width: 100, child: FlutterLogo()),
  );
}
