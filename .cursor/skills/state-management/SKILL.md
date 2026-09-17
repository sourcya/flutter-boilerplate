---
name: state-management
description: Rules for using GetX Controllers, PlayxBinding lifecycles, and DataState for isolated, reactive UI updates.
---

# State Management & Dependency Flow

The app relies heavily on `GetX` for business logic and state, cleanly separated and governed by `PlayxBinding` lifecycles.

## 🔗 1. PlayxBinding Lifecycle

Bindings are scoped to the page router. You must handle injection efficiently without leaking memory.

- `onInitApp`: Runs once at app startup, before this route's `onEnter` ever fires. Use it to register this feature's Repository/Datasource via a static `registerInstance()` on the repository (see `lib/app/products/data/repository/products_repository.dart` and the `dependency-injection` skill), instead of registering feature-scoped dependencies in `AppConfig.bootDependencies()`.
  ```dart
  @override
  Future<void> onInitApp() async {
    ProductsRepository.registerInstance();
  }
  ```
- `onEnter`: Called when navigating to the screen. Initialize your Controllers here.
  ```dart
  Get.put<XController>(XController());
  ```
- `onReEnter`: Called when the page comes back to focus (e.g. popping from a child detail screen). Use this to refresh lists if `wasPoppedAndReentered` is true.
- `onExit`: Clean up your controllers.
  ```dart
  Get.delete<XController>();
  ```

## 🎮 2. Controllers & Observables

- Keep logic *entirely* absent from the UI code. The UI must only call methods on `XController.to`.
- Standard lists and paginated views should extend `BasePagedController<UiType>`. This implements standard fetching loops under the hood automatically.

**State Flow (`DataState`)**:
For specialized widget states, do not use booleans (`isLoading`, `hasError`). Use `DataState` wrappers observed via `.value`:

```dart
final vehiclesState = Rx<DataState<List<TaxiVehicle>>>(const DataState.loading());

// In success block:
vehiclesState.value = DataState.success(wrapper.data);

// In error block:
vehiclesState.value = DataState.fromNetworkError(error);
```
In the UI, you react to this efficiently without calling `setState()`.

## ⏳ 3. App-Wide Async Blocking requests

If you are performing an action that should block user input globally (like submitting a form or deleting an item), coordinate with the global `AppController`:

```dart
try {
  AppController.instance.loadingStatus.value = const LoadingStatus.loading();
  // Perform Network Deletion Request...
  Alert.success("Deleted!");
} catch (e) {
  Alert.error(e.toString());
} finally {
  AppController.instance.loadingStatus.value = const LoadingStatus.idle();
}
```

## 🧹 4. Memory Cleanup

- Destroy text controllers, dispose streams, cancel workers (`everAll`, etc.), and invoke `disposeCancelToken()` (from `CancellationMixin`) inside the `onClose()` method of the `GetxController`.
