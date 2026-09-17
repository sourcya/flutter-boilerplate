# Codemagic / CI

`codemagic.yaml` defines three workflows, all reusing a shared library of named script anchors (`&copy_env_file`, `&get_flutter_packages`, `&analyze`, `&test`, `&build_apk`, `&build_aab`, `&build_ipa`, `&build_web`, etc.):

| Workflow | Instance | What it does |
|---|---|---|
| `web-workflow` | `linux_x2` | Copies the env file, `flutter pub get`, `flutter analyze`, conditional `flutter test`, `flutter build web`. Publishes `build/web/**`. |
| `build-workflow` | `mac_mini_m1` | Sets up `local.properties` and code signing, copies the env file, installs CocoaPods, then builds AAB + APK + IPA. Publishes to Slack (`#default-feed`) on build start. |
| `ios-workflow` | `mac_mini_m1` | Same signing/pods setup, builds only the IPA. |

## Keystore setup

Upload your Android keystore file in the Codemagic UI and reference it under `android_signing:` in `codemagic.yaml` (currently `sourcya_keystore` — rename this group when you rebrand).

## Environment variables in Codemagic

- Define secrets under a `groups:` entry (currently `environment_vars`, `ssh_key`) referenced by each workflow's `environment:` block.
- The `copy_env_file` script writes `$ENVIRONMENT_KEY` (or the legacy `$ENVIROMENT_KEY`) into `assets/env/keys.env` at build time — this is how CI gets real secrets into the app without committing them.
- Configure your Google Play / App Store credentials as Codemagic code-signing groups, referenced the same way.

Continue to the [Commands Reference](commands-reference.md).
