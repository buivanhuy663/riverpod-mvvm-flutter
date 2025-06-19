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
| Dart      | 3.8.1                   |



## Architechture (MVVM)
[Guide to app architecture](https://docs.flutter.dev/app-architecture/guide)

![alt text](https://raw.githubusercontent.com/buivanhuy663/riverpod-mvvm-flutter/refs/heads/main/.github/image/mvvm.png)



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

### Create new screen
run cmd in bash. new_page_name is snake_case
```
bash .template/create_new_page.sh new_page_name
```

### Create a state observable widget
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
        ref.read(provider.notifier).counter();
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


