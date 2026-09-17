# Flutter Boilerplate

Generic Sourcya Flutter starter for Android, iOS, and Web. Copy this project, then add product features — do not add Madaan/TMT business logic here.

## Quick Reference

- **Package name**: `flutter_boilerplate`
- **State management**: GetX
- **Navigation**: GoRouter via `playx_navigation`
- **DI**: `get_it` (global singletons) + `Get.put` (route-scoped controllers)
- **Framework**: [Playx](https://pub.dev/packages/playx) (`playx`, `playx_navigation`, `playx_version_update`)
- **Localization**: Arabic (`ar`) + English (`en`) via Playx JSON translations, fonts Cairo/Segoe
- **Auth**: Email/password via `PlayxNetworkClient` (`TestAuthDataSource` by default; swap to `RemoteAuthDataSource` for a real API)

## Commands

```bash
flutter run
flutter run -d chrome
flutter build apk
flutter analyze
flutter test
```

## Project Structure

```
lib/
├── main.dart
├── core/
│   ├── config/                 # AppConfig boot + constants
│   ├── navigation/src/         # Routes, Paths, AppPages, AppNavigation
│   ├── network/src/            # ApiClient, Endpoints, ApiResponse
│   ├── preferences/            # MyPreferenceManger, EnvManger
│   ├── models/src/             # DataWrapper, PageInfo, Result
│   ├── ui/                     # Design system, theme, DataState, widgets
│   └── utils/                  # Extensions, validation, device utils
└── app/
    ├── app_launch/
    │   ├── app/                # AppController, AppView, drawer/rail
    │   ├── auth/               # Login (register/OTP are extension points)
    │   ├── onboarding/
    │   └── splash/
    ├── dashboard/
    └── settings/
```

## Architecture Rules

Follow `.agent/skills/` (also mirrored in `.cursor/skills/` for Cursor). Summary:

### Feature Structure

```
lib/app/<feature>/
├── data/
│   ├── datasource/    # Abstract + Impl, uses PlayxNetworkClient
│   ├── repository/    # Bridges NetworkResult, maps Api -> Ui models
│   └── model/
│       ├── api/       # ApiX (raw JSON, nullable, fromJson/toJson)
│       ├── ui/        # UiX (immutable, Equatable, copyWith)
│       └── mapper/    # .toUi(), .toApi(), list variants
├── ui/
│   ├── view/          # Stateless views using CustomScaffold
│   ├── controller/    # GetxController
│   ├── binding/       # PlayxBinding
│   └── imports/       # Single barrel file per module
```

### Data Flow

```
API JSON → ApiX.fromJson() → Datasource → Repository (mapDataAsyncInIsolate) → UiX → Controller → View
```

### Dependency Injection

- **Global** (`AppConfig.bootDependencies`): `getIt` for prefs, env, `ApiClient`, `AuthRepository`, `DashboardRepository`, and app-wide `AppController`. Use `PlayxBinding.onInitApp` for feature datasources/repositories when the Playx version supports it.
- **Route-scoped** (`PlayxBinding.onEnter`): delete-then-`Get.put` controllers
- **Cleanup** (`PlayxBinding.onExit`): `Get.delete<XController>()`
- Never mix: no `getIt` in `onEnter`, no feature `Get.put` in `bootDependencies`

### Navigation

- `Routes` + `Paths` in `app_routes.dart`
- Wire routes with bindings in `app_pages.dart`
- Typed methods in `AppNavigation` — never call `PlayxNavigation.toNamed()` from views

### Network

- All endpoints in `lib/core/network/src/endpoints/endpoints.dart`
- Use `PlayxNetworkClient` with `cancelToken` when available
- Repositories map with `mapDataAsyncInIsolate()`

### State

- `DataState<T>` for widget states (not booleans)
- `AppController.instance.loadingStatus` for global blocking overlays
- Dispose controllers, workers, and cancel tokens in `onClose()`

### UI

Always use Custom widgets: `CustomText`, `CustomScaffold`, `CustomElevatedButton`, `CustomCard`, `CustomTextField`, `FeatureChip`.
Colors via `context.colors.*`. Shadows via `Style.shadowSmall(context)`.

### Responsive

- Branch with `context.isAppLandscape` (never `context.isLandscape`)
- `CustomResponsiveBuilder` at the top of feature views
- `.r` for spacing; `.clampedR` for large structural sizes
- `isResponsive: false` on `CustomText` for fixed-size chrome (sidebars, headers)

### Localization

- Keys: `AppTrans` in `lib/core/ui/translation/app_translations.dart`
- JSON: `assets/translations/en.json` and `ar.json`
- Arabic: Modern Standard Arabic. Variables use `{}` with `.tr(args: [...])`

## Agent Skills

| Skill | When to use |
|---|---|
| `feature-architecture` | Creating a new feature module |
| `crud-feature-architecture` | Features with create/edit/details flows |
| `core-architecture` | Navigation routes or preferences |
| `state-management` | Controllers, bindings, reactive state |
| `navigation-architecture` | Routes, bindings, navigation methods |
| `network-architecture` | Endpoints, datasources, repositories |
| `dependency-injection` | Registering dependencies |
| `ui-components` | Choosing Custom widgets |
| `flutter-model-generator` | Api/Ui models and mappers from JSON |
| `localization-manager` | Translation keys |
| `responsive-layout` | Mobile/tablet/web layouts |
| `error-handling` | DataState, DataStateWidget, Alert, loading overlay |
| `view-splitting` | Splitting large views with part/part of |
