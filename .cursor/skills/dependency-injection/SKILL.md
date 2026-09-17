---
name: dependency-injection
description: Architecture for global dependencies (app.dart/getIt) vs route-scoped dependencies (PlayxBinding).
---

# Dependency Injection Architecture

Our application relies on two connected systems to manage memory and dependencies effectively: `getIt` for global singletons and Repositories, and `GetX (Get.put)` wrapped in `PlayxBinding` for localized UI State.

## 🌍 1. Global App Dependencies (`lib/core/config/app.dart`)

Core utilities, services, and managers that live throughout the entire application lifecycle must be initiated in `AppConfig.bootDependencies()`. 

- **Examples**: `ApiClient`, `MyPreferenceManger`, `SecureStorageManager`, `ConnectionStatusController`.
- **Usage**: Register them here via `getIt.registerSingleton()` or let them utilize their own `init()` patterns.

## 📦 2. PlayxBinding: Repositories vs Controllers

The `PlayxBinding` class dictates the local scope of your features. You must split your memory allocations properly to avoid leaks.

- **`onInitApp()`** (when the Playx version exposes it):
  Use this strictly for `getIt.registerLazySingleton`. This is meant for `Datasource` and `Repository` layers. These data handlers are stateless and should be lazy singletons alive throughout the app run once imported by the binding.
  ```dart
  @override
  Future<void> onInitApp() async {
    getIt.registerLazySingleton<XDatasource>(() => XDatasourceImpl());
    getIt.registerLazySingleton<XRepository>(() => XRepositoryImpl(...));
  }
  ```
  This boilerplate currently uses Playx Navigation without `onInitApp` on `PlayxBinding`. Until that API is available, register feature datasources and repositories in `AppConfig.bootDependencies()` instead. Do not add a fake `@override onInitApp()` that does not exist on the current binding class.

- **`onEnter(context, state)`**:
  Use this to allocate your UI Controller logic via `Get.put`. This code runs when the route is actively pushed onto the screen.
  ```dart
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (Get.isRegistered<XController>()) Get.delete<XController>();
    Get.put<XController>(XController());
  }
  ```

- **`onExit(context)`**:
  Deallocate the UI Controller here immediately when the route is removed from the navigation stack to free up memory.
  ```dart
  @override
  Future<void> onExit(BuildContext context) async {
    Get.delete<XController>();
  }
  ```

## ⚠️ Key Takeaway
Do not mix `getIt` inside `onEnter` or `Get.put()` inside `bootDependencies`. Keep Data layer (`getIt`) lazy-global, and UI Layer (`GetX`) strictly route-scoped.
