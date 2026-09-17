---
name: error-handling
description: Guidelines for handling errors, loading states, and user feedback using DataState, DataStateWidget, Alert, and AppController.loadingStatus.
---

# Error Handling & User Feedback

The app uses a layered error handling system: `DataState<T>` for reactive widget state, `DataStateWidget` for rendering state transitions, `Alert` for user notifications, and `AppController.loadingStatus` for global blocking operations.

## DataState<T> — Reactive State Wrapper

`DataState<T>` is a sealed class replacing boolean flags (`isLoading`, `hasError`). Always use it for widget-level state that transitions through loading/success/error.

### States

```dart
DataState.initial()       // initial, before any action
DataState.loading()       // fetching in progress
DataState.success(data)   // operation succeeded
DataState.error(error)    // operation failed
DataState.fromNetworkResult(result)  // convert NetworkResult directly
DataState.fromNetworkError(error)    // convert NetworkException directly
```

### Usage in Controllers

```dart
final vehiclesState = Rx<DataState<List<TaxiVehicle>>>(const DataState.loading());

Future<void> loadVehicles() async {
  vehiclesState.value = const DataState.loading();
  final result = await _repository.getVehicles();
  result.when(
    success: (wrapper) {
      vehiclesState.value = DataState.success(wrapper.data);
    },
    error: (error) {
      vehiclesState.value = DataState.fromNetworkError(error);
    },
  );
}
```

### Checking State

```dart
state.isLoading   // true if Loading
state.isSuccess   // true if Success
state.isError     // true if Failure
state.data        // nullable, available in Success and optionally Loading
state.error       // nullable DataError, available in Failure
```

### Mapping Data

```dart
// Sync transform
final mapped = state.mapData(dataMapper: (data) => data.map(...).toList());

// Async transform
final mapped = await state.asyncMapData(dataMapper: (data) async => ...);
```

## DataError — Error Types

`DataError` is a sealed class with three variants:

| Type | When | Default message key |
|---|---|---|
| `NoInternetError` | No connectivity | `AppTrans.noInternetMessage` |
| `EmptyDataError` | Empty response | `AppTrans.noDataMessage` |
| `DefaultDataError` | General errors | `AppTrans.defaultError` |

Create from network exceptions: `DataError.fromNetworkError(networkException)`

## DataStateWidget<T> — Rendering State

Use `DataStateWidget` in the UI to render different states declaratively. It handles initial, loading, success, error, empty, and no-internet states with default fallback widgets.

```dart
Obx(() => DataStateWidget<List<Vehicle>>(
  data: controller.vehiclesState.value,
  onLoading: (_) => const CustomLoading(),
  onSuccess: (vehicles) => VehicleListView(vehicles: vehicles),
  onEmpty: (message) => EmptyDataWidget(error: message),
  onError: (message) => ErrorWidget(error: message, onRetryClicked: controller.retry),
  onRetryClicked: controller.loadVehicles,
))
```

### Default Fallback Widgets

If you omit a callback, `DataStateWidget` uses these defaults:
- `onLoading` → `CustomLoading()`
- `onEmpty` → `EmptyDataWidget`
- `onError` → `CustomErrorWidget` with retry button
- `noInternetConnection` → `NoInternetWidget` with retry

## Alert — User Notifications

Use the static `Alert` class for transient user feedback (snackbar-style overlays).

```dart
Alert.success(message: 'Vehicle created successfully');
Alert.error(message: 'Failed to delete driver');
Alert.message(message: 'Link copied to clipboard');
Alert.debugError(message: 'Detailed error: $e');  // shows details only in debug mode
```

Parameters:
- `message`: Required string
- `duration`: defaults to 3 seconds
- `isMessageTranslatable`: defaults to `true` (passes through `.tr()`)

Set `isMessageTranslatable: false` for dynamic/server error messages that should not be translated.

## AppController.loadingStatus — Global Loading Overlay

For blocking operations (form submissions, deletions, critical updates) that should prevent all user interaction, use the global loading overlay:

```dart
try {
  AppController.instance.loadingStatus.value = const LoadingStatus.loading();
  await _repository.deleteVehicle(id);
  Alert.success(message: AppTrans.deletedSuccessfully);
} catch (e) {
  Alert.error(message: e.toString());
} finally {
  AppController.instance.loadingStatus.value = const LoadingStatus.idle();
}
```

Always reset to `LoadingStatus.idle()` in the `finally` block to prevent stuck overlays.

## Anti-Patterns

- Using boolean flags (`isLoading`, `hasError`) instead of `DataState<T>`
- Showing raw exception messages to users — use `Alert.debugError` for debug, localized messages for production
- Forgetting to reset `AppController.instance.loadingStatus` after an operation
- Using `AppController.loadingStatus` for non-blocking local loading — use `DataState.loading()` instead
- Catching errors silently without showing user feedback
- Duplicating loading/error/empty widget building — use `DataStateWidget` instead
