import '../../../base/base_page.dart';
import 'new_screen_state.dart';

class NewScreenViewModel extends BaseViewModel<NewScreenState> {
  NewScreenViewModel() : super(NewScreenState.initial());

  void counter() {
    state = state.copyWith(count: state.count + 1);
  }
}
