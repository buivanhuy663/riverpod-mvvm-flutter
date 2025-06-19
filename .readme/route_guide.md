# Guide to Using `GoRouteHelper` Class  
The `GoRouteHelper` class is located in `lib/view/base/go_router.dart` and serves as a utility for managing navigation routes in your Flutter project. Below is a guide on how to use it effectively:

## 1. **Purpose**
The `GoRouteHelper` class simplifies route management by providing predefined routes and navigation logic, ensuring consistency across the app.

## 2. **Setup**
Ensure you have imported the class in your file:
```dart
import 'package:your_project/view/base/go_router.dart';
```

## 3. **Usage**

### Define Routes
The `RouterPath` class typically contains static methods or constants for defining routes. For example:
```dart
class RouterPath {
    static const String homeRoute = '/home';
    static const String settingsRoute = '/settings';
    static const String loginRoute = '/login';
}
```

### Navigate Between Screens
To navigate using `GoRouteHelper`, use the `GoRouter` instance with the predefined routes:
```dart
if (mounted) {
    GoRouteHelper.go(context, RouterPath.login);
}
```

### Handle Parameters
If a route requires parameters, pass them as part of the navigation call:
```dart
if (mounted) {
    GoRouteHelper.go(context, '${RouterPath.login}?userId=123');
}
```

## 4. **Best Practices**
- Centralize all route definitions in `GoRouteHelper` for easier maintenance.
- Use descriptive route names to improve readability.
- Validate parameters before navigating to ensure data integrity.

## 5. **Example**
### Example: Implementing Navigation

Below is an example of how to implement navigation using the `GoRouteHelper` class:

```dart
import 'package:flutter/material.dart';
import 'package:your_project/view/base/go_router.dart';
import 'package:your_project/view/base/router_path.dart';

class ExampleScreen extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text('Example Screen'),
            ),
            body: Center(
                child: ElevatedButton(
                    onPressed: () {
                        if (mounted) {
                            GoRouteHelper.go(context, RouterPath.settingsRoute);
                        }
                    },
                    child: Text('Go to Settings'),
                ),
            ),
        );
    }
}
```

In this example:
- The `RouterPath.settingsRoute` is used to navigate to the settings screen.
- The `GoRouteHelper.go` method ensures consistent navigation logic.
- The `mounted` check prevents navigation if the widget is no longer in the widget tree.
