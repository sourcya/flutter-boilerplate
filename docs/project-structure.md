# Project Structure

```text
lib/
├── main.dart                      # Entry point; boots Playx + AppConfig
├── core/                          # Cross-cutting foundations shared by every feature
│   ├── config/                    # AppConfig.bootDependencies() + app-wide constants
│   ├── navigation/src/            # Routes, Paths, AppPages (GoRouter setup), AppNavigation, AuthGuard
│   ├── network/src/                # ApiClient, Endpoints, ApiResponse, NetworkResult plumbing
│   ├── preferences/                # MyPreferenceManger (secure + plain prefs), EnvManger (.env access)
│   ├── models/src/                 # DataWrapper<T>, PageInfo, Result-style shared models
│   ├── ui/                         # Design system: widgets/, theme, data_state/, translation/, responsive/
│   └── utils/                      # Extensions, validators, device/platform utilities
└── app/                            # Feature code — "package by feature", not by layer
    ├── app_launch/
    │   ├── app/                    # AppController, AppView, navigation drawer/rail chrome
    │   ├── auth/                   # Login, register, OTP, forgot/reset password (extension point, see below)
    │   ├── onboarding/
    │   └── splash/
    ├── dashboard/                  # Minimal feature, "legacy-style" DI (see Dependency Injection)
    ├── products/                   # Reference feature — canonical example of every convention
    └── settings/
```

`core/` never imports from `app/`. Every screen, controller, and feature-specific model lives under `app/<feature>/`, encapsulated end-to-end (its own `data/` and `ui/` layers) — this is the "package by feature" principle: a feature's files live together instead of being scattered across global `views/`, `controllers/`, `models/` folders. It keeps features independently understandable, deletable, and reviewable, and avoids one giant "models" or "controllers" folder growing without bound as the app scales.

See [Architecture: Feature Anatomy](architecture-overview.md#feature-folder-anatomy) for the exact shape every `app/<feature>/` directory follows.
