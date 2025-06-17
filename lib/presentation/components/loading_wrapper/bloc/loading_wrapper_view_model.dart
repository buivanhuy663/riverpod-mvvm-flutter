import 'package:flutter/foundation.dart';

import '../../../core/base_page/base_view_model.dart';
import './loading_wrapper_state.dart';

class LoadingWrapperViewModel extends BaseViewModel<LoadingWrapperState> {
  LoadingWrapperViewModel({@visibleForTesting LoadingWrapperState? state})
    : super(state ?? LoadingWrapperState.initial());

  void showLoading() {
    state = state.copyWith(isShowLoading: true);
  }

  void dismissLoading() {
    state = state.copyWith(isShowLoading: false);
  }
}
