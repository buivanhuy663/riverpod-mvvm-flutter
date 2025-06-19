# Riverpod MVVM Flutter

Boilerplate for flutter app

- Architecture : MVVM
- State management : rivepod
- Dependence : riverpod

## Getting Started

1. Install FVM if you want (https://fvm.app/documentation/getting-started/installation)
2. Install Flutter sdk
3. Run `flutter pub get`
4. Run `flutter pub run build_runner build --delete-conflicting-outputs`
5. Launch

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
