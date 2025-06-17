import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/repository.dart';
import '../../../main/dependence.dart';

extension ViewModelProviderExtension<
  NotifierT extends StateNotifier<StateT>,
  StateT
>
    on AutoDisposeStateNotifierProvider<NotifierT, StateT> {
  NotifierT viewModel(WidgetRef ref) => ref.read(notifier);

  Selected listen<Selected>(
    WidgetRef ref,
    Selected Function(StateT value) selector,
  ) => ref.watch(select(selector));
}

typedef ViewModelProvider<NotifierT extends StateNotifier<StateT>, StateT> =
    AutoDisposeStateNotifierProvider<NotifierT, StateT>;

class BaseViewModel<T> extends StateNotifier<T> {
  BaseViewModel(super.state);

  T get getState => state;

  final Set<Future> _futures = {};

  Repository get repository => injector.read(repositoryProvider);

  @Deprecated(
    'Do not call this method directly for processing. '
    'This is the internal method',
  )
  void addFuture(Future future) {
    _futures.add(future);
  }

  @Deprecated(
    'Do not call this method directly for processing. '
    'This is the internal method',
  )
  void removeFuture(Future future) {
    _futures.remove(future);
  }

  @Deprecated(
    'Do not call this method directly for processing. '
    'This is the internal method',
  )
  void clearAllFuture() {
    _futures.clear();
  }

  @Deprecated(
    'Do not call this method directly for processing. '
    'This is the internal method',
  )
  bool get futuresIsEmpty => _futures.isEmpty;
}
