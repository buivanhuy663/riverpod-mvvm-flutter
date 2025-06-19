import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../base/base_page.dart';
import 'components/counter.dart';
import 'view_model/new_screen_state.dart';
import 'view_model/new_screen_view_model.dart';

final _provider = StateNotifierProvider.autoDispose<NewScreenViewModel, NewScreenState>(
  (ref) => NewScreenViewModel(),
);

class NewScreenPage extends BasePage {
  const NewScreenPage({super.key});

  @override
  BasePageState<NewScreenPage, NewScreenViewModel> createState() => _NewScreenPageState();
}

class _NewScreenPageState extends BasePageState<NewScreenPage, NewScreenViewModel> {
  @override
  NewScreenViewModel get viewModel => _provider.viewModel(ref);

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  @override
  Widget buildBody(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('NewScreen'),
        CounterButton(provider: _provider),
      ],
    ),
  );
}
