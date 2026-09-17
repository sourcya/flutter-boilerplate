---
name: network-architecture
description: Guidelines on using PlayxNetworkClient, extending Endpoints, and handling Strapi ApiResponse wrapped data cleanly.
---

# Network & Strapi API Architecture

The application communicates with a Strapi v4 backend. These backends invariably wrap JSON objects within standard envelopes.

## 🚏 1. Endpoints

All endpoints are strictly defined in `lib/core/network/src/endpoints/endpoints.dart`.
- Never hardcode URL strings inside Datasources or Repositories.
- Use static consts for flat endpoints.
- Use static methods returning interpolated strings if IDs or query parameters are intrinsically tied to the URL path:
  ```dart
  static String getDriverDetails(int driverId) => '$drivers/$driverId';
  ```

## 📡 2. Client & Datasources

All network requests are to be made using `PlayxNetworkClient`. Datasources receive this through dependency injection (defaults to `ApiClient.defaultApiClient`).

**Executing a request:**
- Always pass a `cancelToken` if available.
- Rely on `_client.get<T>()`, `_client.post<T>()`, etc., which return `Future<NetworkResult<T>>`.

## 📦 3. Handling Strapi `ApiResponse`

Strapi wraps payloads in `{ "data": [...], "meta": {} }`. To decode this cleanly, leverage the `ApiResponse` utility class embedded in your JSON mapping function.

**Single Object:**
```dart
fromJson: (json) => ApiResponse.fromJson(
  json: json,
  dataKey: "data", // Adjust if nested under a different key like "vehicle"
  dataFromJson: ApiTaxiVehicle.fromJson,
)
```

**Lists (Paginated):**
```dart
fromJson: (json) => ApiResponse.createApiResponseFromJsonDataList<ApiTaxiDriver>(
  json: json,
  dataFromJson: ApiTaxiDriver.fromJson,
)
```

## 🚚 4. Mapping & Isolate Parsing

Once the raw `ApiX` models bubble up from the Datasource into the Repository layer, you MUST map them to their corresponding `UiX` domain entities.

Because list parsing can cause UI jank in Flutter, always parse them via `mapDataAsyncInIsolate`:

```dart
return res.mapDataAsyncInIsolate(
  mapper: (response) {
    return NetworkResult.success(response.data.toUi()); // Example mapping
  },
);
```
