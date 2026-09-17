# Responsive Layout

The app supports mobile, tablet, and web/desktop from one codebase, built on top of `flutter_screenutil` plus custom extensions in `lib/core/ui/responsive/`.

- **`context.isAppLandscape`** — the single source of truth for portrait-vs-landscape layout branching. **Never** use raw `context.isLandscape` (physical orientation only, ignores screen width). On web/desktop it's `true` when width `>= 1080px`; on a physically-landscape native tablet, `true` when width `>= 840px`; always `false` on native portrait phones. `context.isWideLayout` is an alias for the same getter (`lib/core/ui/responsive/responsive_config.dart`) — `ProductsView` uses it to pick its background color.
- **`CustomResponsiveBuilder`** — use instead of raw `LayoutBuilder` at the top of a feature view; handles cross-fade transitions between layouts and debounced web resize events, and exposes `DeviceInfo`.

| Breakpoint | Value |
|---|---|
| Mobile | `< 600px` |
| Tablet | `600–1080px` |
| Desktop/Web | `>= 1080px` |
| Native tablet landscape threshold | `>= 840px` |

- **`.r`** — standard responsive scaling for spacing/padding/radii/icons (`16.wBox`, `12.radius`). **`.clampedR`** — for large structural sizes (feature cards, dashboard panels); caps upscaling at 110% of design size so layouts don't blow up on ultra-wide/4K monitors.
- **`isResponsive: false`** on `CustomText`, plus raw pixel values, for fixed-size chrome that must never scale (sidebars, app bars, tooltips).
- Keep responsive branching at the page/`components/` level (portrait vs. landscape composition), never buried inside individual field widgets.

Continue to [Localization](localization.md) for the translation system.
