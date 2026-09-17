# Networking

- **Endpoints**: every URL lives in `lib/core/network/src/endpoints/endpoints.dart` as an `Endpoints` static const/method — never hardcode a URL string in a datasource.
- **Client**: `PlayxNetworkClient` wraps Dio and returns `Future<NetworkResult<T>>` from `.get<T>()`/`.post<T>()`/etc. The app's shared, authenticated client is `ApiClient.client` (bootstrapped once in `AppConfig.bootDependencies()` via `ApiClient.init()`), which attaches the bearer token to every request.
- **Envelope parsing — two shapes exist in this repo**:
  - The primary backend (`Endpoints.baseUrl`) uses a Strapi-style envelope (`{"data": ..., "meta": {}}`), decoded via `ApiResponse.fromJson(json: json, dataKey: 'data', dataFromJson: ApiX.fromJson)` or `ApiResponse.createApiResponseFromJsonDataList<ApiX>(...)` for lists (`lib/core/network/src/models/api_response.dart`).
  - Third-party APIs with their own envelope shape are parsed with a dedicated model instead of forcing them through `ApiResponse`. `ApiProductPage` (`lib/app/products/data/model/api/api_product_page.dart`) is the concrete example — dummyjson.com returns `{"products": [...], "total": N, "skip": Y, "limit": X}`, which doesn't fit the Strapi shape, so it gets its own `fromJson`.

## ⚠️ Security callout — never reuse the app's authenticated client for third-party APIs

`Products` fetches from a public API (`dummyjson.com`) and deliberately builds its **own** `PlayxNetworkClient` pointed at `Endpoints.productsBaseUrl`, instead of using `ApiClient.client`:

```dart
// lib/app/products/data/repository/products_repository.dart
final productsClient = PlayxNetworkClient(
  dio: PlayxNetworkClient.createDefaultDioClient(baseUrl: Endpoints.productsBaseUrl),
);
```

If you reused the app's default client here, every request to the third-party API would silently carry your users' bearer token in its headers. Any time a feature talks to an API that isn't your own backend, give it its own unauthenticated (or separately-authenticated) client.

## Isolate-safe mapping

Repositories convert `ApiX` → `UiX` inside `mapDataAsyncInIsolate()` (offloads JSON→model transformation to a background isolate so large lists don't jank the UI thread). See `ProductsRepositoryImpl.getPaginatedProducts` for the full pattern.

Continue to [Error Handling](error-handling.md) for how `NetworkResult` failures become user-facing state.
