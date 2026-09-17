---
name: feature-architecture
description: Guidelines for setting up new features, datasources, and repositories following the strict clean modular architecture.
---

# Feature Architecture Guidelines

All features inside `lib/app/...` follow a strict structural pattern. DO NOT organize by layer (like `views/`, `controllers/` globally); keep them encapsulated per feature.

### 📁 Feature Directory Structure

```text
lib/app/<feature>/
├── ui/
│   ├── view/           # Pure UI, CustomScaffold, Stateless preferred
│   ├── controller/     # GetxController (Business Logic only)
│   ├── binding/        # PlayxBinding (DI scopes)
│   └── imports/        # <feature>_imports.dart
├── data/
│   ├── repository/     # I<Feature>Repository + Implementation
│   ├── datasource/     # I<Feature>Datasource (API calls)
│   └── model/
│       ├── api/        # Raw JSON structs (ApiX) - Immutable
│       ├── ui/         # Domain entities (UiX) - Immutable, Equatable
│       └── mapper/     # Extension methods (.toUi(), .toApi())
```

## 🌐 Datasource Setup

- Create an abstract class `XDatasource` and its implementation `XDatasourceImpl`.
- Use `PlayxNetworkClient` for HTTP requests (`_client.get`, `_client.post`).
- Return type should always be wrapped in `Future<NetworkResult<ApiResponse<ApiX>>>` (or `List<ApiX>`).
- API models must map strictly to JSON. Rely on `ApiResponse.fromJson(...)` wrappers.

## 💾 Repository Setup

- Repositories are responsible for bridging `NetworkResult` and transforming data using mappers.
- Return type should be `Future<NetworkResult<DataWrapper<UiX>>>`.
- **CRITICAL FORMATTING**: Use `mapDataAsyncInIsolate()` to offload complex model transformations to a background isolate. 
  Example:
  ```dart
  return _dataSource.getPaginatedDrivers(...).then((res) {
    return res.mapDataAsyncInIsolate(
      mapper: (response) {
        final dataWrapper = response.toDataWrapperAndMapData(
          mapper: (data) => response.data.toListTaxiDriver(),
        );
        return NetworkResult.success(dataWrapper);
      },
    );
  });
  ```
- No UI logic should leak into the Repository; UI Models out, API Models enclosed.
