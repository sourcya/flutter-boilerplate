---
name: localization-manager
description: Manages translation keys for a Flutter app including generating Dart constants (AppTrans) and English/Arabic JSON files. Mentions playx ecosystem translations setup.
---

# App Localization and Translation Manager

This skill manages translation keys for the Flutter app. 
The translations are stored in two places:
1. **AppTrans class** (Dart constants) located at: `lib/core/ui/translation/app_translations.dart`
2. **JSON translation files** in `assets/translations/` (one for `en.json` and one for `ar.json`).

⚡ **Task:**
Whenever requested to provide new labels, fields, error messages, or UI text:
1. Generate a **Dart constant key** inside the `AppTrans` class (always `static const`).
2. Add the corresponding key/value to both `en.json` (English) and `ar.json` (Modern Standard Arabic, not dialect).
3. Keep Arabic translations short, clear, and user-friendly. Prefer using the definite article “الـ” when natural (e.g., "المسارات" instead of "مسارات").
4. If a message contains variables (e.g., placeholders), use `{}` in translations, and mention that they will be replaced with `.tr(args: [...])`.
5. If shorter versions are requested, make them concise but still meaningful.
6. Always return **all three parts**: Dart constants, English JSON, Arabic JSON.

## Additional Task (File Search):
When asked to **search within certain files or directories** (e.g., `lib/app/...` or `assets/translations/...`) to:
- Extract existing translation keys.
- Identify missing translations.
- Suggest updates for consistency between Dart constants and JSON files.

**Action:**
- First, list the found translation keys/strings.
- Then, generate or fix the missing constants and JSON translations in the same format.

---

### Example Input:
```
addCoordinateLabel
editCoordinateLabel
noCoordinatesAdded
```

### Expected Output:
```dart
// AppTrans class
static const addCoordinateLabel = 'addCoordinateLabel';
static const editCoordinateLabel = 'editCoordinateLabel';
static const noCoordinatesAdded = 'noCoordinatesAdded';
```

```json
// en.json
{
  "addCoordinateLabel": "Add Coordinate",
  "editCoordinateLabel": "Edit Coordinate",
  "noCoordinatesAdded": "No coordinates added"
}
```

```json
// ar.json
{
  "addCoordinateLabel": "إضافة إحداثية",
  "editCoordinateLabel": "تعديل إحداثية",
  "noCoordinatesAdded": "لا توجد إحداثيات مضافة"
}
```

---

✅ From now on, every time you provide new labels or ask to extract from files, I will follow the same structure:
* Dart keys (`AppTrans`)
* English JSON
* Arabic JSON
* (If file search: show found keys, then add/fix missing ones)

---

### App Specific Playx Localization Details

You should be aware of the following local specifics regarding translations in this App:

**Configuration (`lib/core/ui/translation/app_locale_config.dart`)**:
`AppLocaleConfig` creates the Playx `PlayxLocaleConfig` with standard `supportedLocales` like `arabicLocale` (id `ar`) and `englishLocale` (id `en`). It pairs standard fonts for these locales (`Cairo` for Arabic, `Segoe` for English).

**Initialization (`lib/main.dart`)**:
The translation config is wired in directly during `Playx.runPlayx()` bootstrap using:
`localeConfigBuilder: () => AppLocaleConfig.localeConfig`

**Usage with `CustomText` (`lib/core/ui/widgets/components/custom_text.dart`)**:
By default `CustomText("someText")` has `isTranslatable: true`. It executes `"someText".tr(...)` automatically based on the text string you provide.
- **IMPORTANT**: If there are strings being rendered by `CustomText` that should **not** receive translation attempts (e.g. dynamic variables, backend text, purely numeric strings), you MUST set `isTranslatable: false` inside the `CustomText` to prevent unwanted `.tr()` behavior.
