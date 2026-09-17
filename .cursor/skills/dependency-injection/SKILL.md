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

- **`onInitApp()`**:
  Supported on this boilerplate's `PlayxBinding` (Playx Navigation 2.1.0+) - it runs once at app startup, before the route's `onEnter` ever fires. Use it for a feature's `Datasource`/`Repository` registration instead of cramming everything into `AppConfig.bootDependencies()`. The canonical shape, following `lib/app/products/`:

  The repository owns its own registration via a static `registerInstance()`, guarded with `isRegistered` checks so it's safe to call more than once:
  ```dart
  // products_repository.dart
  abstract class ProductsRepository {
    static ProductsRepository get instance => getIt<ProductsRepository>();

    static void registerInstance() {
      if (!getIt.isRegistered<ProductsDatasource>()) {
        getIt.registerLazySingleton<ProductsDatasource>(
          () => ProductsDatasourceImpl(client: ...),
        );
      }
      if (!getIt.isRegistered<ProductsRepository>()) {
        getIt.registerLazySingleton<ProductsRepository>(
          () => ProductsRepositoryImpl(dataSource: getIt<ProductsDatasource>()),
        );
      }
    }
    // ...abstract methods...
  }
  ```
  The binding just calls it:
  ```dart
  @override
  Future<void> onInitApp() async {
    ProductsRepository.registerInstance();
  }
  ```
  Keep `AppConfig.bootDependencies()` for things that are truly app-wide and unrelated to any single route (e.g. `MyPreferenceManger`, `EnvManger`, `ApiClient`, `AuthRepository`, `DashboardRepository`). Use `onInitApp()` specifically for feature-scoped datasources/repositories that belong to a routed feature - it keeps the registration co-located with the feature instead of piling into `app_config.dart`.

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
