
# 🧱 Guide to Using `BasePage` and `BaseViewModel`

This document explains how to use the `BasePage` architecture pattern with `Riverpod`, 
designed to simplify page and state management in Flutter.

---

## 🚀 Getting Started

Each screen in the application should inherit from `BasePage` instead of using `StatefulWidget` directly.

```dart
class MyPage extends BasePage {
  const MyPage({super.key});

  @override
  ConsumerState<BasePage> createState() => _MyPageState();
}

class _MyPageState extends BasePageState<MyPage, MyViewModel> {
  @override
  MyViewModel get viewModel => ref.read(myViewModelProvider.notifier);

  @override
  Widget buildBody(BuildContext context) {
    return const Text("Hello from MyPage");
  }
}
```

---

## 🧠 ViewModel: `BaseViewModel`

All page logic should be handled in a class that extends `BaseViewModel<T>`.

```dart
class MyViewModel extends BaseViewModel<MyState> {
  MyViewModel() : super(MyState());
}
```

```dart
final ViewModelProvider<LoginViewModel, LoginState> provider;
```

---

## 🧩 Lifecycle Methods

These lifecycle hooks are provided via `BasePageMixin`:

- `onInitState()`: Called in `initState()`, before context is available.
- `onStateCreated(context)`: Called after widget tree is built.
- `onAppearedPage()`: Called when the page appears on screen again.
- `onDisappearedPage()`: Called when the page is hidden or disposed.
- `onDispose()`: Called in `dispose()` lifecycle.
- `onRefreshPage()`: Called when page is reloaded due to refresh trigger.
- `onPopWithResult()`: Optional method to handle data when navigating back.

---

## 🧰 Utilities

### Loading Dialog

```dart
showLoadingDialog();
dismissLoadingDialog();
forceDismissLoading();
```

### Error Handling

```dart
handleError(error); // Shows platform dialog with error
handlerFutureError(error); // Prevents duplicate dialogs
```

---

## 📦 Helpers & Extensions

### `ViewModelProviderExtension`

```dart
myViewModelProvider.viewModel(ref); // get Notifier
myViewModelProvider.listen(ref, (state) => state.myProperty); // selective listening
```

---

## 🧼 Notes

- `PopScope` is used to detect when the page is popped.
- `VisibilityWrapper` triggers page re-appear and disappear callbacks.
- `GestureDetector` handles tap-to-hide-keyboard if `tapOutsideHideKeyBoard == true`.
- Safe area support is toggled via `hasUseSafeArea`.

---

## 📚 Summary

This base setup ensures consistency and scalability for managing pages, view models, loading, errors, and lifecycle in Flutter apps using Riverpod.
