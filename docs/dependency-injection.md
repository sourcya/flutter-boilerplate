# Dependency Injection: Two Patterns

The boilerplate uses **two** registration styles side by side. Both are correct — pick based on scope, and both are real, running code in this repo today.

## 1. App-wide singletons — `AppConfig.bootDependencies()`

`lib/core/config/app_config.dart`

Anything that must exist for the entire app lifetime, independent of any single route: preferences, env access, the shared `ApiClient`, `AuthRepository`, and the app-wide `AppController`. `DashboardRepository`/`DashboardDatasource` are also registered here today — this is the **older/simpler style**, fine for a feature with no real data layer yet:

```dart
// lib/core/config/app_config.dart
getIt.registerSingleton<MyPreferenceManger>(MyPreferenceManger());
getIt.registerSingleton<EnvManger>(EnvManger());
await ApiClient.init();
// ...
if (!getIt.isRegistered<DashboardDatasource>()) {
  getIt.registerLazySingleton<DashboardDatasource>(DashboardDatasourceImpl.new);
}
if (!getIt.isRegistered<DashboardRepository>()) {
  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepository(dataSource: getIt.get<DashboardDatasource>()),
  );
}
```

Dashboard's controller is then created directly in `DashboardBinding.onEnter` by passing the already-registered repository in:

```dart
// lib/app/dashboard/ui/binding/dashboard_binding.dart
Get.put(DashboardController(repository: DashboardRepository.instance));
```

## 2. Feature-scoped, route-owned — `registerInstance()` + `PlayxBinding.onInitApp()`

The newer, preferred style. Used by `Products` — the repository owns its own registration, guarded with `isRegistered` checks so it's safe to call more than once:

```dart
// lib/app/products/data/repository/products_repository.dart
abstract class ProductsRepository {
  static ProductsRepository get instance => getIt<ProductsRepository>();

  static void registerInstance() {
    if (!getIt.isRegistered<ProductsDatasource>()) {
      getIt.registerLazySingleton<ProductsDatasource>(
        () => ProductsDatasourceImpl(client: productsClient),
      );
    }
    if (!getIt.isRegistered<ProductsRepository>()) {
      getIt.registerLazySingleton<ProductsRepository>(
        () => ProductsRepositoryImpl(dataSource: getIt<ProductsDatasource>()),
      );
    }
  }
  // ...abstract methods
}
```

```dart
// lib/app/products/ui/binding/products_binding.dart
class ProductsBinding extends PlayxBinding {
  @override
  Future<void> onInitApp() async {
    ProductsRepository.registerInstance();
  }

  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    if (Get.isRegistered<ProductsController>()) Get.delete<ProductsController>();
    Get.put<ProductsController>(ProductsController());
  }
  // onReEnter / onExit — see Navigation
}
```

`onInitApp()` runs once at app startup, before this route's `onEnter` ever fires — see [Navigation](navigation.md#playxbinding-lifecycle) for the full `PlayxBinding` lifecycle table.

## When to use which

Reach for `AppConfig.bootDependencies()` only for things every screen in the app might need regardless of navigation (prefs, env, the shared API client, auth). For anything tied to a specific routed feature — which is almost everything you'll build — use the `registerInstance()` + `onInitApp()` pattern like Products. Never mix them: no `getIt` registration inside `onEnter`, and no feature `Get.put()` inside `bootDependencies()`.
