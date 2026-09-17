# Agent Skills Reference

Both Claude Code and Cursor read the same rules — `.agent/skills/` and `.cursor/skills/` are kept byte-for-byte identical (13 skills each). Consult the relevant skill before touching that part of the codebase; each one is more exhaustive than the summary in these docs.

| Skill | Governs | Reach for it when... |
|---|---|---|
| `feature-architecture` | The `data/`/`ui` folder shape every feature must follow, plus the abstract+impl+`registerInstance()` repository pattern | Starting any new feature module |
| `crud-feature-architecture` | `create_x`/`edit_x`/`x_form`/`x_details` module split and controller-ownership rules | A feature has overlapping create/edit/details flows, not just a list |
| `core-architecture` | `lib/core/navigation/` and `lib/core/preferences/` conventions | Adding routes or touching local storage |
| `dependency-injection` | `AppConfig.bootDependencies()` vs. `PlayxBinding.onInitApp()`/`onEnter`/`onExit` | Registering any new dependency, global or feature-scoped |
| `navigation-architecture` | `Routes`/`Paths`, `AppPages`, binding-to-route wiring, typed `AppNavigation` methods | Adding or changing a route |
| `network-architecture` | `Endpoints`, `PlayxNetworkClient`, `ApiResponse` envelope parsing, isolate-safe mapping | Adding an API call or a new datasource |
| `state-management` | GetX controllers, `PlayxBinding` lifecycle, `DataState`, `BasePagedController` | Writing or refactoring a controller |
| `error-handling` | `DataState`/`DataError`/`DataStateWidget` defaults, `Alert`, `AppController.loadingStatus` | Handling loading/empty/error states or user feedback |
| `ui-components` | The `Custom*` design-system widgets and when to use each | Building any screen |
| `flutter-model-generator` | Generating `ApiX`/`UiX` models and mapper extensions from a JSON payload | Turning API JSON into app models |
| `localization-manager` | `AppTrans` + `en.json`/`ar.json` key conventions | Adding or auditing translation strings |
| `responsive-layout` | `context.isAppLandscape`, breakpoints, `.r`/`.clampedR`, `CustomResponsiveBuilder` | Building a layout that must work on mobile, tablet, and web |
| `view-splitting` | The `part`/`part of` pattern for breaking up large view files | A view file exceeds ~150–200 lines or grows `_build` helpers |

Continue to [Environment Variables](environment-variables.md).
