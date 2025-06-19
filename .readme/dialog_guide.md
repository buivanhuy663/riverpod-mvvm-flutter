# 💬 Guide to Using `BaseDialog<R>`

`BaseDialog` is a base class for building reusable and customizable dialogs in Flutter, with lifecycle and result management included.

---

## 📦 Purpose

- **Standardize dialog implementation**
- **Manage dialog lifecycle** (show / dismiss / return value)
- **Generic return type support** (`R`)

---

## 🧩 How to Use

### Step 1: Create a Custom Dialog Class

```dart
class ConfirmDialog extends BaseDialog<bool> {
    ConfirmDialog({super.key});

    @override
    Widget build(BuildContext context) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
                const Text('Confirm Action'),
                Row(
                    children: [
                        TextButton(onPressed: () => dismiss(result: false), child: const Text('Cancel')),
                        TextButton(onPressed: () => dismiss(result: true), child: const Text('OK')),
                    ],
                ),
            ],
        );
    }
}
```

---

### Step 2: Show the Dialog

```dart
final result = await ConfirmDialog().show(context);
if (result == true) {
    // do something
}
```

---

## 📌 Advanced Customization

- **`elevation`**: Dialog elevation
- **`backgroundColor`**: Background color
- **`isDismissible`**: Whether tapping outside closes the dialog

---

## 🔁 Managing Return Values

- **`dismiss(result: R?)`**: Closes the dialog with an optional result
- **`onDismissDialog()`**: Override this to return a fallback result if `dismiss()` is called without a value
