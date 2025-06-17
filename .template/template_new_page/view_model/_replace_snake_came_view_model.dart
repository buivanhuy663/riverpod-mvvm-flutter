import '../../../base/base_page.dart';
import '_replace_snake_came_state.dart';

class ReplacePascalCameViewModel extends BaseViewModel<ReplacePascalCameState> {
  ReplacePascalCameViewModel() : super(ReplacePascalCameState.initial());

  void counter() {
    state = state.copyWith(count: state.count + 1);
  }
}
