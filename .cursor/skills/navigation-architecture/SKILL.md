---
name: navigation-architecture
description: Guidelines on using PlayxNavigation, GoRouter, route declarations, and associating Bindings to routes.
---

# Navigation Architecture & Bindings

The application uses `playx_navigation` which is a wrapper around the standard `go_router` package. All routing logic and screen declarations exist inside `lib/core/navigation/`.

## 🧭 1. Route Trees (`app_pages.dart` & `app_routes.dart`)

- **Strict Paths**: Never use raw strings in views. Define `Routes` (names) and `Paths` (URL paths) in `app_routes.dart`.
- **Top-Level Routes**: Use `PlayxRoute` to declare independent screens (like login, splash).
- **Navigation Drawer / Tabs**: Use `PlayxShellBranch` within the `StatefulShellRoute.indexedStack` (represented by `_homeNavigationRoutes`) to organize dashboard-level feature branches.

## 🔗 2. Binding to Routes

Whenever you create a new View, it must be paired with its `Binding` during route declaration in `app_pages.dart`. This ensures the dependency injection lifecycle triggers specifically when that route is encountered.

```dart
// Example of an isolated route
PlayxRoute(
  path: Paths.update,
  name: Routes.update,
  builder: (context, state) => const UpdateView(),
  binding: UpdateBinding(), // Important: Link the scope!
),

// Example of a nested feature inside the Home Navigation Shell
PlayxShellBranch(
  path: Paths.drivers,
  name: Routes.drivers,
  builder: (context, state) => const DriversView(),
  binding: DriversBinding(), 
  routes: [
    // Nested Details route
    PlayxRoute(
      name: Routes.driverDetails,
      path: Paths.driverDetails,
      builder: (context, state) => const DriverDetailsView(),
      binding: DriverDetailsBinding(),
    ),
  ],
)
```

## 🚗 3. Executing Navigation

- **Never** call `PlayxNavigation.toNamed()` directly from a View UI.
- Always create a static, strongly-typed method inside `lib/core/navigation/src/app_navigation.dart` that enforces the required arguments (`extra` payload or `pathParameters`).

```dart
// Valid navigation method in AppNavigation
static void navigateToDriverDetails({required TaxiDriver driver}) {
  PlayxNavigation.toNamed(
    Routes.driverDetails,
    extra: driver,
    pathParameters: {'id': driver.id.toString()},
  );
}
```
