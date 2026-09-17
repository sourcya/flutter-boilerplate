# Building a New Feature, Step by Step

Using `lib/app/products/` as the worked example, here's the sequence of files you'd create for a new read-only list feature (for create/edit/details flows, jump straight to the `crud-feature-architecture` skill instead):

1. **Endpoint** — add the URL to `lib/core/network/src/endpoints/endpoints.dart` (e.g. `static const products = '/products';`, plus a separate `productsBaseUrl` constant if it's a third-party API).
2. **API model** — `data/model/api/api_<feature>.dart`: nullable fields, `fromJson`/`toJson`, no logic. Add a page/envelope model too (`api_<feature>_page.dart`) if the API's list response doesn't fit the shared `ApiResponse` envelope (see `api_product_page.dart`).
3. **UI model** — `data/model/ui/<feature>.dart`: non-nullable with defaults, `extends Equatable`, `copyWith()`.
4. **Mapper** — `data/model/mapper/<feature>_mapper.dart`: `extension Api<Feature>Mapper on Api<Feature> { <Feature> toUi() {...} }` plus a `List<Api<Feature>>` extension for `.toUiList()`.
5. **Datasource** — `data/datasource/<feature>_datasource.dart`: abstract `<Feature>Datasource` + `<Feature>DatasourceImpl`, calling `PlayxNetworkClient` against the endpoint from step 1. Give it its own `PlayxNetworkClient` instead of `ApiClient.client` if it's a third-party API (see the security callout in [Networking](networking.md)).
6. **Repository** — `data/repository/<feature>_repository.dart`: abstract `<Feature>Repository` (with `static instance` and `static registerInstance()`, guarded by `isRegistered` checks) + `<Feature>RepositoryImpl`, mapping `NetworkResult<ApiX>` → `NetworkResult<DataWrapper<List<UiX>>>` via `mapDataAsyncInIsolate`.
7. **Controller** — `ui/controller/<feature>_controller.dart`: extend `BasePagedController<UiX>`, implement `fetchPage()`.
8. **Binding** — `ui/binding/<feature>_binding.dart`: `onInitApp()` calls `<Feature>Repository.registerInstance()`; `onEnter`/`onExit` put/delete the controller; add `onReEnter` if the list should refresh when popped back to.
9. **View + widgets** — `ui/view/<feature>_view.dart` on `CustomScaffold`, rendering `ResponsivePagedSliverView<int, UiX>` inside a `CustomScrollView`; extract item widgets under `ui/view/widgets/`.
10. **Imports barrel** — `ui/imports/<feature>_imports.dart` gathering every `part` for the binding/controller/view/widgets above.
11. **Routes** — add `Routes.<feature>` / `Paths.<feature>` to `app_routes.dart`, then wire a `PlayxRoute(..., binding: <Feature>Binding())` into `AppPages.routes` (top-level) or into a `StatefulShellBranch` inside `_homeNavigationRoutes` (dashboard shell) in `app_pages.dart`.
12. **Navigation method** — add a typed `AppNavigation.navigateTo<Feature>()` in `app_navigation.dart`; never call `PlayxNavigation.toNamed()` from a view.
13. **Translations** — add every user-facing string to `AppTrans` plus `en.json`/`ar.json`.

Continue to the [Agent Skills Reference](skills-reference.md) for the full, machine-readable rules behind each of these steps.
