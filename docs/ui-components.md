# UI Components

Never use raw Flutter widgets when a `Custom*` wrapper exists — they carry theming, localization, and responsive scaling that raw widgets don't. All live under `lib/core/ui/widgets/`:

| Instead of | Use | Why |
|---|---|---|
| `Text` | `CustomText` (`components/custom_text.dart`) | Themed fonts (Cairo/Segoe), auto `.tr()` translation, responsive sizing |
| `Scaffold` | `CustomScaffold` (`components/custom_scaffold.dart`) | Consistent app bar, loading overlay, safe-area/back-button handling; pass `title:` directly |
| `ElevatedButton` | `CustomElevatedButton` (`buttons/custom_elevated_button.dart`) | Built-in `isLoading`, standardized radius/padding |
| `Card` | `CustomCard` (`components/custom_card.dart`) | Theme-aware surface color (light/dark), optional elevation, `enableHover`. There is no `.glass(...)` factory — configure via `color`/`elevation`/`shadowBorderRadius`/`shouldShowCustomShadow` instead. |
| `TextField` | `CustomTextField` (`components/text_field.dart`) | Unified input style, validation, error/label handling |
| `Chip` | `FeatureChip` (`components/feature_chip.dart`) | Auto-scaling label, theme-aware color, `isLabelTranslatable` |

Other widgets you'll reach for often: `CustomGirdListSwitch` (grid/list toggle, used in `ProductsView`'s `actions:`), `CustomGridView`, `CustomSearch` (`components/form_field/text_field/search/custom_search.dart`), `CustomLoading`, `EmptyDataWidget`, `NoInternetWidget`, `ErrorDataWidget` (`widgets/state/`), and `ImageViewer` (from the `playx_widget` package via `playx` — e.g. `ImageViewer.cachedNetwork(url)`, as used in `ProductGridTileWidget`).

- **Colors**: always `context.colors.primary` / `.surface` / `.mutedForeground` / etc. — never hardcoded hex values.
- **Shadows/elevation**: `Style.shadowSmall(context)` (`lib/core/ui/resources/style/style.dart`) rather than raw `BoxShadow`s.
- **`CustomText.isTranslatable`**: defaults to `true` (it calls `.tr()` on the string you pass). Set it to `false` for data-bound text — usernames, prices, IDs, category names pulled from an API — so it isn't run through the translation lookup. `ProductGridTileWidget` sets `isTranslatable: false` on the product title and `isLabelTranslatable: false` on its `FeatureChip` category label for exactly this reason.

Before assuming a widget has a param or named factory beyond what's shown here, check its actual constructor in `lib/core/ui/widgets/` — this table is a summary, not a substitute for reading the widget.

Continue to [Responsive Layout](responsive-layout.md) for how these widgets adapt across mobile/tablet/web.
