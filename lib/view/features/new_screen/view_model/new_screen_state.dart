import 'package:freezed_annotation/freezed_annotation.dart';

part 'new_screen_state.freezed.dart';

@freezed
sealed class NewScreenState with _$NewScreenState {
  const factory NewScreenState({required int count}) = _NewScreenState;

  const NewScreenState._();

  factory NewScreenState.initial() => const NewScreenState(count: 0);
}
