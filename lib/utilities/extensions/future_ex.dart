// ignore_for_file: deprecated_member_use_from_same_package
part of './extensions.dart';

extension FutureEx<T> on Future<T> {
  /// Call this function to show a loading full screen on page
  Future<T> subscribeLoadingFullScreen(BasePageState pageState) {
    pageState.viewModel.addFuture(this);
    pageState.showLoadingDialog();
    return whenComplete(() {
      pageState.viewModel.removeFuture(this);
      pageState.dismissLoadingDialog();
    });
  }

  /// Call this method to subscribe to receive data when the data returns
  /// successfully. Note future must be a future that returns data
  Future<T> subscribeOnSuccess(
    BasePageState pageState, {
    Function(T data)? success,
  }) => then((value) {
    success?.call(value);
    return this;
  });

  /// Call this method to subscribe to receive error on catch error.
  Future<T> subscribeHandleError(
    BasePageState pageState, {
    Function(Object? error)? onError,
  }) => catchError((error) {
    pageState.viewModel.clearAllFuture();
    pageState.dismissLoadingDialog();
    if (onError == null) {
      pageState.handlerFutureError(error);
    } else {
      onError.call(error);
    }
  });
}
