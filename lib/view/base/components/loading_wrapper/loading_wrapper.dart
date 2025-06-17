import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../base_page/base_view_model.dart';
import '../progress_indicator_platform.dart';
import 'viewmodel/loading_wrapper_state.dart';
import 'viewmodel/loading_wrapper_view_model.dart';

class LoadingWrapper extends ConsumerWidget {
  const LoadingWrapper({
    required this.provider,
    this.child = const SizedBox(),
    super.key,
  });

  final ViewModelProvider<
    LoadingWrapperViewModel,
    LoadingWrapperState
  >
  provider;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Stack(
    children: [
      child,
      if (ref.watch(provider).isShowLoading)
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.transparent,
          child: const Center(child: ProgressIndicatorPlatform()),
        ),
    ],
  );
}
