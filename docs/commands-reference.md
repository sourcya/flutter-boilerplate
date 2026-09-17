# Commands Reference

All `rps` scripts are defined in `pubspec.yaml`'s `scripts:` block and run with `dart run rps <name>` (no global `rps` install required, since it's a project dev dependency).

| Command | What it does |
|---|---|
| `dart run rps setup` | Full new-project bootstrap: `pub get` → rename package/app → regenerate icons → regenerate splash → generate keystore |
| `dart run rps rename` | Applies `package_rename_config.yaml` (app name, bundle/package id) to Android/iOS/web |
| `dart run rps icons` | Regenerates launcher icons from `flutter_launcher_icons.yaml` |
| `dart run rps splash` | Regenerates native Android/iOS splash screens from the `flutter_native_splash:` block in `pubspec.yaml` |
| `dart run rps analyze` | Runs `flutter analyze` |
| `dart run rps test` | Runs `flutter test` if a `test/` directory exists, otherwise skips |
| `dart run rps format` | Runs `dart format .` |
| `dart run rps clean` | Runs `flutter clean` |
| `dart run rps build-web` | Runs `flutter build web --release` |
| `dart run rps gen` | Runs `dart run build_runner build --delete-conflicting-outputs` once |
| `dart run rps watch` | Runs `dart run build_runner watch --delete-conflicting-outputs` continuously |

Plain `flutter` commands you'll still use directly:

```sh
flutter run              # run on a connected device/simulator
flutter run -d chrome    # run in Chrome
flutter build apk        # build a release Android APK
flutter analyze          # static analysis (same as `dart run rps analyze`)
flutter test             # run tests (same as `dart run rps test`, minus the directory guard)
```
