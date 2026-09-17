# Tech Stack & Getting Started

## Tech Stack

| Layer | Choice | Notes |
|---|---|---|
| Language / SDK | Dart, Flutter | `sdk: '>=3.10.0 <4.0.0'` (see `pubspec.yaml`) |
| State management | [GetX](https://pub.dev/packages/get) | Controllers + reactive (`.obs`, `Rx`) state, route-scoped via bindings |
| Navigation | [`playx_navigation`](https://pub.dev/packages/playx) | Thin, typed wrapper around `go_router` (`PlayxRoute`, `PlayxShellBranch`, `PlayxBinding`) |
| Dependency injection | [`get_it`](https://pub.dev/packages/get_it) + GetX `Get.put` | `getIt` for global/data-layer singletons, `Get.put` for route-scoped controllers |
| App framework | [Playx](https://pub.dev/packages/playx) ecosystem | `playx`, `playx_navigation` (bundled in `playx`), `playx_version_update` |
| Networking | `PlayxNetworkClient` (Dio wrapper, via `playx`) | `NetworkResult<T>` success/error wrapper, `ApiResponse` envelope parsing |
| Pagination | [`infinite_scroll_pagination`](https://pub.dev/packages/infinite_scroll_pagination) (forked, see below) | Drives `BasePagedController` + `ResponsivePagedSliverView` |
| Localization | Playx localization (Easy Localization under the hood) | `ar` + `en`, JSON translation files, Cairo/Segoe fonts |
| Responsive UI | `flutter_screenutil` (via custom extensions) | `.r` / `.clampedR` scaling, `CustomResponsiveBuilder` |
| Error tracking | Sentry (`SentryNavigatorObserver`) | Wired into `AppPages.router` |
| Dev tooling | [`rps`](https://pub.dev/packages/rps) | Runs the named scripts in `pubspec.yaml`'s `scripts:` block — no global install needed |

The `infinite_scroll_pagination` dependency points at a git fork (`basemosama/infinite_scroll_pagination`, branch `fix-paging-controller-refresh`) rather than the published package — see the `dependencies:` block in `pubspec.yaml` if you need to update or re-point it.

## Getting Started

### 1. Clone and install dependencies

```sh
git clone <your-new-repo-url>
cd <your-new-repo>
flutter pub get
```

`rps` is a **dev dependency** already declared in `pubspec.yaml`, so every `dart run rps <script>` command below works without any global activation.

### 2. Run the setup script

```sh
dart run rps setup
```

This runs the `setup` script defined in `pubspec.yaml`'s `scripts:` block, which chains, in order:

1. `flutter pub get` — fetches dependencies.
2. `dart run package_rename --path="package_rename_config.yaml"` — renames the Android/iOS/web app name, bundle ID, and package name using the values in `package_rename_config.yaml`.
3. `flutter pub run flutter_project_name_changer:main sourcya` — renames the Dart package itself (the `name:` field in `pubspec.yaml` and all corresponding imports) to `sourcya`.
4. `dart run flutter_launcher_icons` — regenerates launcher icons from `flutter_launcher_icons.yaml` (see [Icons & Splash Screen](icons-and-splash.md)).
5. `dart run flutter_native_splash:create` — regenerates the native Android/iOS splash screen from the `flutter_native_splash:` block in `pubspec.yaml`.
6. `dart run scripts/generate_keystore.dart` — generates a new Android debug/release keystore (`keystore.jks`) with a random secure password, printed to the console.

Run this **once**, right after cloning, before you start building product features. Edit `package_rename_config.yaml` and change the `sourcya` argument in step 3 above (inside `pubspec.yaml`'s `setup` script) to match your new app's name before running it.

### 3. Rename the app / bundle ID manually (optional)

If you only need to change the name/bundle ID later (without re-running the full `setup` flow), edit `package_rename_config.yaml`:

```yaml
package_rename_config:
  android:
    app_name: Sourcya
    package_name: io.sourcya.app
  ios:
    app_name: Sourcya
    bundle_name: sourcya
    package_name: io.sourcya.app
  web:
    app_name: Sourcya
    description: Sourcya Flutter application.
```

Then apply it with:

```sh
dart run rps rename
```

### 4. Update the launcher icon and splash screen

See the full [Icons & Splash Screen](icons-and-splash.md) guide. Short version: replace `assets/images/logo.png`, adjust `flutter_launcher_icons.yaml` and/or the `flutter_native_splash:` block in `pubspec.yaml`, then run `dart run rps icons` and/or `dart run rps splash`.

### 5. Configure environment variables

```sh
cp assets/env/keys.env.example assets/env/keys.env
```

Fill in real values in `assets/env/keys.env` (e.g. `SENTRY_KEY`). This file is git-ignored — see [Environment Variables](environment-variables.md) for details on how it's loaded and what keys exist today.

### 6. Run the app

```sh
flutter run           # Android/iOS (connected device or simulator)
flutter run -d chrome # Web
```
