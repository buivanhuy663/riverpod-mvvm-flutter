import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/base_page.dart';
import '../view_model/_replace_snake_came_state.dart';
import '../view_model/_replace_snake_came_view_model.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({
    required this.provider,
    required this.onPressed,
    super.key,
  });

  final ViewModelProvider<ReplacePascalCameViewModel, ReplacePascalCameState> provider;

  final Function() onPressed;

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
