# Environment Variables

Environment variables keep secrets (API keys, DSNs) out of source control.

## Usage

1. Copy the checked-in example to the real (git-ignored) file:

   ```sh
   cp assets/env/keys.env.example assets/env/keys.env
   ```

   `assets/env/keys.env.example` currently defines:

   ```sh
   SENTRY_KEY=
   SHOW_VERSION_CODE=false
   ```

2. `*.env` is already covered by `.gitignore` — never commit `assets/env/keys.env`.

## Loading `.env` in Flutter

The bootstrap loads `assets/env/keys.env` automatically when it exists, and falls back to the safe checked-in example when it doesn't. Access values through `EnvManger` (`lib/core/preferences/env_manger.dart`), which wraps `PlayxEnv`:

```dart
final sentryKey = await EnvManger.instance.sentryKey;          // PlayxEnv.getString('SENTRY_KEY')
final showVersionCode = await EnvManger.instance.showVersionCode; // PlayxEnv.getBool('SHOW_VERSION_CODE')
```

Add new keys by extending `EnvManger` with a matching getter, and add the raw key to both `keys.env.example` and your local `keys.env`.

Continue to [Icons & Splash Screen](icons-and-splash.md).
