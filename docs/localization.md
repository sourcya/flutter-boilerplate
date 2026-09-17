# Localization

- **Keys**: `AppTrans` (`lib/core/ui/translation/app_translations.dart`, ~340 lines / 280+ keys today) — every user-facing string gets a `static const` key here.
- **Values**: `assets/translations/en.json` and `assets/translations/ar.json`, kept in lockstep (same key set in both files).
- **Arabic**: Modern Standard Arabic, not dialect; prefer the definite article ("الـ") where natural.
- **Variables**: use `{}` placeholders in the JSON string and pass values with `.tr(args: [...])`.
- **`CustomText`**: automatically calls `.tr()` when `isTranslatable` is `true` (the default) — see the [UI Components](ui-components.md) note on when to turn it off.
- Adding a new locale on iOS also requires listing it under `CFBundleLocalizations` in `ios/Runner/Info.plist`.

Continue to [View Splitting](view-splitting.md) for how large view files get broken up.
