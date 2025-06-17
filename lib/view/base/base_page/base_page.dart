import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../utils/helpers/error_helper.dart';
import '../../resources/resources.dart';
import '../base_dialog/dialog_platform.dart';
import '../components/loading_wrapper/loading_wrapper.dart';
import '../components/loading_wrapper/viewmodel/loading_wrapper_state.dart';
import '../components/loading_wrapper/viewmodel/loading_wrapper_view_model.dart';
import '../components/visibility_wrapper.dart';
import '../refresh_service.dart';
import 'base_page_mixin.dart';
import 'base_view_model.dart';

/// Every page needs to inherit from this class.
/// A page should not be created with `StateFulWidget`
abstract class BasePage extends ConsumerStatefulWidget {
  const BasePage({super.key});
}

abstract class BasePageState<Page extends BasePage, VM extends BaseViewModel>
    extends ConsumerState<Page>
    with BasePageMixin, WidgetsBindingObserver {
  late LoadingWrapperViewModel _loadingViewModel;

  final _loadingProvider =
      StateNotifierProvider.autoDispose<
        LoadingWrapperViewModel,
        LoadingWrapperState
      >((ref) => LoadingWrapperViewModel());

  bool isShowingError = false;

  /// This is the only presenter of the page.
  /// Use it instead of creating a new presenter.
  ///
  VM get viewModel;

  @override
  @Deprecated('Override `onInitState()` instead of `initState()`')
  void initState() {
    super.initState();
    //Inject instance presenter for this page
    RefreshService.addPageInitialized(pageName);
    _loadingViewModel = ref.read(_loadingProvider.notifier);
    onInitState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => onStateCreated(context),
    );
  }

  @override
  @mustCallSuper
  @Deprecated(
    'Override `buildPage()` instead of `build()`. '
    'If it is required to override build, can ignore this line',
  )
  Widget build(BuildContext context) => buildPage(context);

  @override
  @Deprecated('Override `onDispose()` instead of `dispose()`')
  void dispose() {
    RefreshService.removePageInitialized(pageName);
    onDispose();
    super.dispose();
  }

  PreferredSizeWidget? buildAppBar(BuildContext context) => null;

  Widget buildBody(BuildContext context);

  Widget buildPage(BuildContext context) => PopScope(
    onPopInvokedWithResult: onPopWithResult(),
    child: LoadingWrapper(
      provider: _loadingProvider,
      child: hasUseSafeArea
          ? SafeArea(child: _bodyInsideSafeArea())
          : _bodyInsideSafeArea(),
    ),
  );

  Widget _bodyInsideSafeArea() => VisibilityWrapper(
    onAppeared: () {
      onAppearedPage();
      if (RefreshService.hadRefresh(pageName)) {
        RefreshService.removePage(pageName);
        onRefreshPage();
      }
    },
    onDisappeared: onDisappearedPage,
    child: GestureDetector(
      onTap: tapOutsideHideKeyBoard
          ? () {
              FocusScope.of(context).requestFocus(FocusNode());
            }
          : null,
      child: Scaffold(
        backgroundColor: backgroundColor ?? AppColors.of(context).background,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        appBar: buildAppBar(context),
        body: buildBody(context),
      ),
    ),
  );

  void showLoadingDialog() {
    _loadingViewModel.showLoading();
  }

  void dismissLoadingDialog() {
    // ignore: deprecated_member_use_from_same_package
    if (viewModel.futuresIsEmpty) {
      _loadingViewModel.dismissLoading();
    }
  }

  void forceDismissLoading() {
    _loadingViewModel.dismissLoading();
  }

  /// If override this function, you should not call super,
  /// dialog error will show the first error of the page
  Future<void> handleError(Object? error) async {
    await DialogPlatform(content: ErrorHelper.getError(error)).show(context);
  }

  /// If override this function, you should not call super,
  /// dialog error show duplicate if have many error
  void handlerFutureError(Object? error) {
    if (!isShowingError) {
      isShowingError = true;
      handleError(error);
      isShowingError = false;
    }
  }
}
