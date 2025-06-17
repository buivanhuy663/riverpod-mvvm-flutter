import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base_page.dart';
import 'progress_indicator_platform.dart';

class LoadingWrapper extends ConsumerWidget {
  const LoadingWrapper({
    required this.provider,
    this.child = const SizedBox(),
    super.key,
  });

  final ViewModelProvider<LoadingWrapperViewModel, bool> provider;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Stack(
    children: [
      child,
      if (provider.listen(ref, (value) => value))
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: const Center(child: ProgressIndicatorPlatform()),
        ),
    ],
  );
}

class LoadingWrapperViewModel extends BaseViewModel<bool> {
  LoadingWrapperViewModel({@visibleForTesting bool? isShowing}) : super(isShowing ?? false);

  void showLoading() {
    state = true;
  }

  void dismissLoading() {
    state = false;
  }
}
