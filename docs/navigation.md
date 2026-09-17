# Navigation

Routing runs on `playx_navigation` (a typed wrapper around `go_router`), configured in `lib/core/navigation/src/`:

- **`app_routes.dart`** — `Routes` (route names) and `Paths` (URL paths) as plain string constants. Never hardcode route strings in a view.
- **`app_pages.dart`** — `AppPages.router` (the `GoRouter` instance), `AppPages.routes` (top-level `PlayxRoute`s: splash, login, forget/reset password, onboarding, products), and `AppPages._homeNavigationRoutes` — a `StatefulShellRoute.indexedStack` with `StatefulShellBranch`es for the tab/drawer shell (`dashboard`, `settings`, `reports`, `analytics`). Every route is paired with a `PlayxBinding` (e.g. `ProductsBinding()`) right where it's declared.
- **`app_navigation.dart`** — `AppNavigation`, the *only* place that calls `PlayxNavigation.toNamed()` / `offAllNamed()` / `pop()`. Views call typed static methods like `AppNavigation.navigateToProducts()`, never the raw navigation API.
- **`auth_guard.dart`** — `AuthGuard.redirect`, wired into `AppPages.router` via `redirect:`, gates access to authenticated routes.

## PlayxBinding lifecycle

Used across the whole app:

| Hook | When it runs | Typical use |
|---|---|---|
| `onInitApp()` | Once, at app startup, before this route's `onEnter` ever fires | Register this feature's datasource/repository via `registerInstance()` — see [Dependency Injection](dependency-injection.md) |
| `onEnter(context, state)` | Every time the route is pushed | `Get.put()` the controller |
| `onReEnter(context, state, wasPoppedAndReentered)` | When the route regains focus (e.g. popping back from a child screen) | Refresh data if `wasPoppedAndReentered` is true |
| `onExit(context)` | When the route leaves the stack | `Get.delete()` the controller |

`ProductsBinding` uses all four:

```dart
// lib/app/products/ui/binding/products_binding.dart
@override
Future<void> onReEnter(BuildContext context, GoRouterState? state, bool wasPoppedAndReentered) async {
  if (!Get.isRegistered<ProductsController>()) return;
  final controller = Get.find<ProductsController>();
  if (wasPoppedAndReentered) controller.refreshData();
}
```

Continue to [State Management](state-management.md) for how controllers themselves are structured.
