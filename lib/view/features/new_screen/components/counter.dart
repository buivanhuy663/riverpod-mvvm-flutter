import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/base_page.dart';
import '../view_model/new_screen_state.dart';
import '../view_model/new_screen_view_model.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({
    required this.provider,
    super.key,
  });

  final ViewModelProvider<NewScreenViewModel, NewScreenState> provider;


  @override
  Widget build(BuildContext context) => Consumer(
    builder: (context, ref, child) => ElevatedButton(
      onPressed: () {
        provider.viewModel(ref).counter();
      },
      child: Text('${provider.listen(ref, (state) => state.count)}'),
    ),
  );
}
