---
name: ui-components
description: Guidelines and rules for using the mandatory UI components and widgets in the app. Avoid raw Flutter widgets when custom wrappers exist.
---

# UI Components Guidelines

This app relies heavily on a custom design system built on top of Flutter widgets in `lib/core/ui/widgets/components`. You MUST use these custom widgets to ensure consistent styling, theming, scaling, and localization.

## 🧱 Core Replacements

Never use the raw Flutter equivalents. Always use the `Custom*` implementations:

| Standard Widget | Sourcya Replacement | Why? |
| --- | --- | --- |
| `Text` | `CustomText` | Handles localized fonts (Cairo/Segoe), translation (`.tr()`), and responsive design automatically. |
| `Scaffold` | `CustomScaffold` | Handles platform-specifics, loading overlays, and standard App Bar consistency. Pass title directly as `title: '...'`. |
| `ElevatedButton` | `CustomElevatedButton` | Includes loading states optionally, standardized border radius, and gradients. |
| `Card` | `CustomCard` | Theme-aware container (`lib/core/ui/widgets/components/custom_card.dart`). Configure via `color`, `elevation`, `shadowBorderRadius`, `shouldShowCustomShadow`, `enableHover` — there is no `.glass(...)` factory, don't invent one. |
| `TextField` | `CustomTextField` | Unified input style, validation, error/label handling, and focus management. |
| `Chip` | `FeatureChip` | For tags/capsules. Auto-scales text size and handles colors based on current theme. |

## 🌟 Visual Excellence

- **Aesthetics First**: Aim for modern, premium designs using the real widget APIs above — check the widget's actual constructor in `lib/core/ui/widgets/components/` before assuming a param or named factory exists.
- **Colors**: Never hardcode Hex colors. Always depend on `context.colors.primary`, `surface`, `success`, etc.
- **Elevation**: Avoid raw Shadows. Rely on App Theme components or `Style.shadowSmall(context)`.

## 📝 CustomText Deep Dive

`CustomText` is automatically hooked up to the localization framework (`playx`).
- By default `isTranslatable: true`. It executes `"String".tr(...)` implicitly.
- Set `isTranslatable: false` for data-bound text, usernames, numeric readouts, and identifiers, to avoid `.tr()` trying to map them to translation dictionary keys.
