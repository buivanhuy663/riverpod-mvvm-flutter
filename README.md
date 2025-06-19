# Riverpod MVVM Flutter

Boilerplate for flutter app

- Architecture : MVVM
- State management : rivepod
- Dependence : riverpod

## Getting Started

1. Install FVM if you want. [Flutter Version Management](https://fvm.app/documentation/getting-started/installation)
2. Install [Flutter sdk](https://docs.flutter.dev/get-started/install)
3. Run `flutter pub get`
4. Run `flutter pub run build_runner build --delete-conflicting-outputs`
5. Launch



## <a name="environment">#</a> ⛩ Environment
| Framework | version                   |
| --------- | ----------------------    |
| Flutter   | 3.32.2 (stable release)   |
| Dart      | 3.8.1                     |



## Architechture (MVVM)
[Guide to app architecture](https://docs.flutter.dev/app-architecture/guide)

![alt text](https://raw.githubusercontent.com/buivanhuy663/riverpod-mvvm-flutter/refs/heads/main/.github/image/mvvm.png)


## Library
| Category          | Library                 | Version     |
|-------------------|-------------------------|-------------|
| **State management** | flutter_riverpod         | ^2.6.1      |
| **UI**               | cupertino_icons          | ^1.0.8      |
|                      | cached_network_image     | ^3.4.1      |
|                      | flutter_svg              | ^2.2.0      |
|                      | visibility_detector      | ^0.4.0+2    |
| **REST API**         | http                     | ^1.4.0      |
|                      | dio                      | ^5.8.0+1    |
|                      | retrofit                 | ^4.1.0      |
| **Store**            | shared_preferences       | ^2.5.3      |
|                      | flutter_secure_storage   | ^9.2.4      |
| **Utils**            | device_info_plus         | ^11.4.0     |
|                      | package_info_plus        | ^8.3.0      |
|                      | connectivity_plus        | ^6.1.4      |
|                      | window_manager           | ^0.5.0      |
|                      | freezed                  | ^3.0.6      |
|                      | freezed_annotation       | ^3.0.0      |
|                      | go_router                | ^15.1.3     |
|                      | json_annotation          | ^4.9.0      |
|                      | logger                   | ^2.5.0      |
|                      | responsive_framework     | ^1.5.1      |
|                      | pretty_dio_logger        | ^1.4.0      |


## File struct
```
lib/
├── main.dart
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
├── utils/
│   ├── constants/
│   ├── extensions/
│   └── helpers/
├── view/
│   ├── app.dart
│   ├── base/
│   ├── entities/
│   ├── features/
│   │   └── page_one/
│   │       ├── page.dart
│   │       └── viewmodel/
│   │           ├── state.dart
│   │           └── view_model.dart
│   └── resources/
```

## How to

### Create new screen (Suggest)
run cmd in bash or git bash terminal. new_page_name is snake_case
```
bash .template/create_new_page.sh new_page_name
```
to create a page with struct
```
lib/view/features
│   │   └── new_page_name/
│   │       ├── new_page_name.dart
│   │       └── viewmodel/
│   │           ├── new_page_name_state.dart
│   │           └── new_page_name_view_model.dart
```

Every page needs to inherit from `BasePage` class
```dart
/// Every page needs to inherit from `BasePage` class.
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
}

// We have
// This provide state notifier management
final _provider = StateNotifierProvider.autoDispose<LoginViewModel, LoginState>(
  (ref) => LoginViewModel(),
);

class LoginPage extends BasePage {
  const LoginPage({super.key});

  @override
  BasePageState<LoginPage, LoginViewModel> createState() => _LoginPageState();
}

class _LoginPageState extends BasePageState<LoginPage, LoginViewModel> {
  @override
  LoginViewModel get viewModel => ref.read(_provider.notifier);
}
```

### Create a widget observable state
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../base/base_page.dart';
import '../view_model/new_screen_state.dart';
import '../view_model/new_screen_view_model.dart';

class CounterButton extends StatelessWidget {
  const CounterButton({
    required this.provider,
    required this.onPressed,
    super.key,
  });

  final ViewModelProvider<NewScreenViewModel, NewScreenState> provider;

  final Function() onPressed;

  @override
  Widget build(BuildContext context) => Consumer(
    builder: (context, ref, child) => ElevatedButton(
      onPressed: () {
        provider.viewModel(ref).counter()
      },
      child: Text('${provider.listen(ref, (state) => state.count)}'), // provider.listen
    ),
  );
}
```
### Use app resource
- Colors
1. Add new color to `app_color.dart`
2. Use `AppColors.get.background`

- Texts
1. Add text to `lib/view/resources/strings/*.arb` file
2. Run `fvm flutter gen-l10n` to gen `app_localizations`
3. Use `AppText.get?.enter_password`

- Images
1. Add image to assets/images
2. Change app_image.dart

- Network image
1. Use widget in `lib\view\base\components\network_image.dart`


### Guide
1. [Route Guide](https://github.com/buivanhuy663/riverpod-mvvm-flutter/blob/main/.readme/route_guide.md).

