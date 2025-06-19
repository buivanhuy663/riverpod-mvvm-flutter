# 🎨 Guide to Using AppColors and ColorsDefine  

The `AppColors` and `ColorsDefine` classes provide a unified solution for managing colors across your Flutter app, with built-in support for light and dark themes.  

---

## 🧩 How It Works  

- `AppColors.get` is the single entry point to fetch app colors.  
- It automatically returns a `ColorsDefine` instance based on the current theme brightness.  
- `ColorsDefine` holds core UI colors such as `blueMain`, `background`, `text`, etc.  

---

## ✅ Usage  

### Get a color in any widget:  
```dart  
final color = AppColors.get.primary;  
```  

### Apply to UI:  
```dart  
Text(  
    'Title',  
    style: TextStyle(color: AppColors.get.text),  
)  

Container(  
    color: AppColors.get.background,  
)  
```  

---

## 🌗 Theme Support (Light/Dark)  

When the app theme switches (`ThemeMode.light` / `ThemeMode.dark`), `AppColors.get` returns the correct set of colors (`colorsLight` or `colorsDark`).  

### Example:  
- **Light theme:** `background = white`, `text = black`  
- **Dark theme:** `background = black`, `text = white`  

---

## 📌 Notes  

- `AppColors.get` relies on `navigatorKey.currentContext`, so it must be called after the app is fully built.  
- Avoid using `ColorsDefine.colorsLight` or `colorsDark` directly to preserve dynamic theming behavior.  
