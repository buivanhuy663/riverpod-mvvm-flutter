# ⚡️ Guide to Using `FutureEx<T>` Extension  

The `FutureEx<T>` extension simplifies working with `Future` inside `BasePageState`, including full-screen loading, success handling, and unified error management.  

---

## 🔄 Overview  

This extension enhances any `Future<T>` by allowing:  

- **Automatic full-screen loading**  
- **Clean success callback handling**  
- **Standardized error processing**  

---

## 🌀 Show Full-Screen Loading  

### ✅ Usage:  
```dart  
myFuture.subscribeLoadingFullScreen(this);  
```  
- `this` refers to an instance of `BasePageState`.  
- Automatically shows loading when the future starts.  
- Automatically hides loading when the future completes.  
- Integrated with internal future tracking inside the `viewModel`.  
- Commonly used together with `subscribeHandleError` and `subscribeOnSuccess`.  

---

## 🎯 Handle Success  

### ✅ Usage:  
```dart  
myFuture.subscribeOnSuccess(this, success: (data) {  
  // handle the returned data here  
});  
```  
- The `success` callback is invoked when the future completes successfully.  
- `data` is the returned value of `Future<T>`.  

---

## ❌ Handle Error  

### ✅ Usage:  
```dart  
myFuture.subscribeHandleError(this);  
```  
Or if you want to customize the error handling:  
```dart  
myFuture.subscribeHandleError(this, onError: (error) {  
  // custom error handling  
});  
```  
- If `onError` is not provided, the system will call `handlerFutureError()` to show the default error dialog.  
- It will also automatically clear all futures and dismiss loading.  

---

## 🧩 Combine All  

### Real Example:  
```dart  
repository.getData().subscribeLoadingFullScreen(this)  
  .subscribeOnSuccess(this, success: (data) {  
    // handle data  
  })  
  .subscribeHandleError(this);  
```  
- ✅ Readable  
- ✅ Automatic  
- ✅ Standardized across the project  

---

## 📌 Notes  

- The methods `addFuture`, `removeFuture`, and `clearAllFuture` are internal and already called within the extension.  
