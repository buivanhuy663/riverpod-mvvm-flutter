# Riverpod MVVM Flutter

Boilerplate for flutter app

- Architecture : MVVM
- State management : riverpod
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



## Architecture (MVVM)
[Guide to app architecture](https://docs.flutter.dev/app-architecture/guide)

![alt text](https://raw.githubusercontent.com/buivanhuy663/riverpod-mvvm-flutter/refs/heads/main/.github/image/mvvm.png)


## Library
| Category             | Library                  |
|----------------------|------------------------- |
| **State management** | flutter_riverpod         |
| **UI**               | cupertino_icons          |
|                      | cached_network_image     |
|                      | flutter_svg              |
|                      | visibility_detector      |
| **REST API**         | http                     |
|                      | dio                      |
|                      | retrofit                 |
| **Store**            | shared_preferences       |
|                      | flutter_secure_storage   |
| **Utils**            | device_info_plus         |
|                      | package_info_plus        |
|                      | connectivity_plus        |
|                      | window_manager           |
|                      | freezed                  |
|                      | freezed_annotation       |
|                      | go_router                |
|                      | json_annotation          |
|                      | logger                   |
|                      | responsive_framework     |
|                      | pretty_dio_logger        |


## File struct
```
lib/
├── main.dart
├── data/
│   ├── models/
│   ├── repositories/
│   └── services/
├── utils/
│   ├── constants/
│   ├── extensions/
│   └── helpers/
├── view/
│   ├── app.dart
│   ├── base/
│   ├── entities/
│   ├── features/
│   │   └── page_one/
│   │       ├── page.dart
│   │       └── view_model/
│   │           ├── state.dart
│   │           └── view_model.dart
│   └── resources/
```
### Guide
1. [Route ](https://github.com/buivanhuy663/riverpod-mvvm-flutter/blob/main/.readme/route_guide.md).
2. [New Page ](https://github.com/buivanhuy663/riverpod-mvvm-flutter/blob/main/.readme/guide_using_base_page.md).
3. [New Dialog ](https://github.com/buivanhuy663/riverpod-mvvm-flutter/blob/main/.readme/dialog_guide.md).
4. [Future loading ](https://github.com/buivanhuy663/riverpod-mvvm-flutter/blob/main/.readme/guide_future_ex.md).
5. [Theme ](https://github.com/buivanhuy663/riverpod-mvvm-flutter/blob/main/.readme/colors_guide.md).
6. [Image ](https://github.com/buivanhuy663/riverpod-mvvm-flutter/blob/main/.readme/.readme/image_guide.md).
7. [Svg ](https://github.com/buivanhuy663/riverpod-mvvm-flutter/blob/main/.readme/svg_guide.md).




## How to

### Create new screen (Suggest)
run cmd in bash or git bash terminal. new_page_name is snake_case
```
bash .template/create_new_page.sh new_page_name
```
to create a page with struct
```
lib/view/features
│   │   └── new_page_name/
│   │       ├── new_page_name.dart
│   │       └── view_model/
│   │           ├── new_page_name_state.dart
│   │           └── new_page_name_view_model.dart
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



