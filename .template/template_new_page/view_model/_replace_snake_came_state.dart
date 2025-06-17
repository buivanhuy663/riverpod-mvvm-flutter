import 'package:freezed_annotation/freezed_annotation.dart';

part '_replace_snake_came_state.freezed.dart';

@freezed
sealed class ReplacePascalCameState with _$ReplacePascalCameState {
  const factory ReplacePascalCameState({required int count}) =
      _ReplacePascalCameState;

  const ReplacePascalCameState._();

  factory ReplacePascalCameState.initial() =>
      ReplacePascalCameState(count: 0);
}
