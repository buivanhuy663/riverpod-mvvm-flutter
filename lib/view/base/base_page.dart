import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/repository.dart';
import '../../main/dependence.dart';
import '../../utils/helpers/error_helper.dart';
import '../../utils/helpers/logger_helper.dart';
import '../resources/resources.dart';
import 'base_dialog/dialog_platform.dart';
import 'components/loading_wrapper.dart';
import 'components/visibility_wrapper.dart';
import 'refresh_service.dart';

/// Every page needs to inherit from this class.
/// A page should not be created with `StateFulWidget`
abstract class BasePage extends ConsumerStatefulWidget {
  const BasePage({super.key});
}

abstract class BasePageState<Page extends BasePage, VM extends BaseViewModel>
    extends ConsumerState<Page>
    with BasePageMixin, WidgetsBindingObserver {
  late LoadingWrapperViewModel _loadingViewModel;

  final _loadingProvider = StateNotifierProvider.autoDispose<LoadingWrapperViewModel, bool>(
    (ref) => LoadingWrapperViewModel(),
  );

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
    _loadingViewModel = _loadingProvider.viewModel(ref);
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
      child: hasUseSafeArea ? SafeArea(child: _bodyInsideSafeArea()) : _bodyInsideSafeArea(),
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
        backgroundColor: backgroundColor ?? AppColors.get.background,
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

mixin BasePageMixin {
  /// This function is called when the start page state is initialized.
  /// Can't get context here
  @mustCallSuper
  void onInitState() {
    LoggerHelper.info('[Page][$pageName] is initializing state');
  }

  /// This function is called when the page state has been created.
  /// The context can be obtained here
  @mustCallSuper
  void onStateCreated(BuildContext context) {
    LoggerHelper.info('[Page][$pageName] is created state');
  }

  /// This function is called when this page is re-rendered on the screen
  /// (Instance reappears after being completely covered by another page
  /// or newly created).
  ///
  /// In case of page transition effect,
  /// the modal is called when the actual page transition is finished
  @mustCallSuper
  void onAppearedPage() {
    LoggerHelper.info('[Page][$pageName] is appeared');
  }

  /// This function is called when this page disappears from the screen
  /// (In case it is completely covered by another page or page is disposed).
  ///
  /// In case of page transition effect,
  /// the modal is called when the actual page transition is finished
  @mustCallSuper
  void onDisappearedPage() {
    LoggerHelper.info('[Page][$pageName] is disappeared');
  }

  /// This function is called when the page is actually disposed
  @mustCallSuper
  void onDispose() {
    LoggerHelper.info('[Page][$pageName] is disposing ');
  }

  @mustCallSuper
  void onRefreshPage() {
    LoggerHelper.info('[Page][$pageName] reloading');
  }

  /// When this function is overridden.
  /// It will be called when a pop command is called on the navigator.
  PopInvokedWithResultCallback? onPopWithResult() => null;

  bool get resizeToAvoidBottomInset => false;

  /// If this property is `true`
  /// then it will allow tap outside the screen to hide the keyboard
  bool get tapOutsideHideKeyBoard => false;

  /// This is page background color
  Color? get backgroundColor => null;

  /// If this property is `true`
  /// then it will wrap this page by the `SafeArea` Widget
  bool get hasUseSafeArea => false;

  String get pageName => (this as State).widget.runtimeType.toString();
}

extension ViewModelProviderExtension<NotifierT extends StateNotifier<StateT>, StateT>
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
