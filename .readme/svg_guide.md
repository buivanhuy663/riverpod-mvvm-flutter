# 🖼️ Guide to Using AppSvg  

AppSvg is a custom widget for managing SVG assets in a centralized and convenient way within a Flutter project.  

## 📦 Purpose  
- Centralized SVG path management via `_SvgPath`.  
- Expose reusable SVGs as static constants for easier use.  
- Support for optional width and height.  

## ✅ Usage  

### Show default SVG  
```dart  
AppSvg.todoChecked  
```  

### Show SVG with custom size  
```dart  
AppSvg.todoChecked.copyWith(width: 24, height: 24)  
```  
⚠️ Default size is `100` if no width/height is provided.  

## 🧩 Advanced Customization  
In the `build()` method, you can extend it with:  
- `colorFilter`: to apply custom color.  
- `semanticsLabel`: for accessibility.  

```dart  
SvgPicture.asset(  
  path,  
  width: width,  
  height: height,  
  colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),  
)  
```  

## 📌 Notes  
- All SVGs must be placed under `assets/svg_icons`, defined via `_SvgPath`.  
- No need to re-declare in `pubspec.yaml` if `assets/` root is already included.  
