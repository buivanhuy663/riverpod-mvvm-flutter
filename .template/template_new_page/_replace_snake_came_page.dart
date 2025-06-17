import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../base/base_page.dart';
import 'view_model/_replace_snake_came_state.dart';
import 'view_model/_replace_snake_came_view_model.dart';

final _provider =
    StateNotifierProvider.autoDispose<ReplacePascalCameViewModel, ReplacePascalCameState>(
      (ref) => ReplacePascalCameViewModel(),
    );

class ReplacePascalCamePage extends BasePage {
  const ReplacePascalCamePage({super.key});

  @override
  BasePageState<ReplacePascalCamePage, ReplacePascalCameViewModel> createState() =>
      _ReplacePascalCamePageState();
}

class _ReplacePascalCamePageState
    extends BasePageState<ReplacePascalCamePage, ReplacePascalCameViewModel> {
  @override
  ReplacePascalCameViewModel get viewModel => ref.read(_provider.notifier);

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @override
  Widget buildBody(BuildContext context) => const Center(
    child: Text('ReplacePascalCame'),
  );
}
