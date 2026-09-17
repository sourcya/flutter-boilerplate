# Error Handling

- **`DataState<T>`** (`lib/core/ui/data_state/models/data_state.dart`) — sealed-class wrapper replacing boolean flags: `DataState.initial()`, `.loading()`, `.success(data)`, `.error(error)`, `.fromNetworkResult(result)`, `.fromNetworkError(error)`. Check with `.isLoading` / `.isSuccess` / `.isError`, transform with `.mapData()` / `.asyncMapData()`.
- **`DataError`** (`lib/core/ui/data_state/models/data_error.dart`) — sealed class with `NoInternetError`, `EmptyDataError`, `DefaultDataError` variants, each with a default translated message key.
- **`DataStateWidget<T>`** (`lib/core/ui/data_state/widgets/data_state_widget.dart`) — renders a `DataState<T>` declaratively; if you omit a callback it falls back to sensible defaults: `onLoading` → `CustomLoading()`, `onEmpty`/`NoInternetError` → `EmptyDataWidget`/`NoInternetWidget`, `onError`/`DefaultDataError` → `ErrorDataWidget` with a retry button.
- **`Alert`** — static class for transient user feedback: `Alert.success(message: ...)`, `Alert.error(message: ...)`, `Alert.message(message: ...)`, `Alert.debugError(message: ...)` (shown only in debug builds). Pass `isMessageTranslatable: false` for dynamic/server-provided messages.
- **`AppController.instance.loadingStatus`** — see [State Management](state-management.md); always paired with a `try/catch/finally` that resets it to `idle()`.

## Anti-patterns to avoid

- Boolean `isLoading`/`hasError` flags instead of `DataState`.
- Showing raw exception text to users.
- Forgetting to reset `loadingStatus`.
- Hand-rolling loading/error/empty widget branches instead of using `DataStateWidget`.

Continue to [UI Components](ui-components.md) for the widgets these states render into.
