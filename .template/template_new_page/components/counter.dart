import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_model/_replace_snake_came_state.dart';
import '../view_model/_replace_snake_came_view_model.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({
    required this.provider,
    required this.onPressed,
    super.key,
  });

  final AutoDisposeStateNotifierProvider<ReplacePascalCameViewModel, ReplacePascalCameState>
  provider;

  final Function() onPressed;

  @override
  Widget build(BuildContext context) => Consumer(
    builder: (context, ref, child) => ElevatedButton(
      onPressed: () {
        ref.read(provider.notifier).counter();
      },
      child: Text('${ref.watch(provider.select((value) => value.count))}'),
    ),
  );
}
