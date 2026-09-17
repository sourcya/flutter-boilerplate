---
name: responsive-layout
description: Guidelines for building responsive UIs across mobile, tablet, and web using the app's responsive system, breakpoints, scaling extensions, and CustomResponsiveBuilder.
---

# Responsive Layout Architecture

The app supports mobile (portrait), tablet, and web/desktop (landscape) layouts with a unified responsive system built on top of `ScreenUtil` and custom extensions in `lib/core/ui/widgets/responsive/`.

## Layout Branching — Single Source of Truth

Always use `context.isAppLandscape` to decide between portrait and landscape layouts. Never use `context.isLandscape` (raw Playx extension) — it only checks physical orientation and ignores screen width.

```dart
// Correct
if (context.isAppLandscape) {
  return LandscapeLayout();
} else {
  return PortraitLayout();
}

// Wrong — do not use
if (context.isLandscape) { ... }
```

### How `isAppLandscape` works

- **Web/Desktop platforms**: `true` when `screenWidth >= 1080.0`
- **Native mobile in physical portrait**: always `false`
- **Native tablet in physical landscape**: `true` when `screenWidth >= 840.0`

## CustomResponsiveBuilder

Use `CustomResponsiveBuilder` at the top level of feature views instead of raw `LayoutBuilder`. It handles:
- Smooth cross-fade animation between layouts
- Debounced web browser resize events
- Provides `DeviceInfo` with `type`, `orientation`, `width`, `height`

```dart
CustomResponsiveBuilder(
  builder: (context, deviceInfo) {
    if (context.isAppLandscape) {
      return LandscapeView();
    }
    return PortraitView();
  },
)
```

## Breakpoints

| Breakpoint | Value | Use |
|---|---|---|
| Mobile | `< 600px` | Phone layout |
| Tablet | `600px – 1080px` | Tablet portrait |
| Desktop/Web | `>= 1080px` | Landscape/web layout |
| Landscape (web) | `>= 1080px` | `isAppLandscape` threshold |
| Landscape (native tablet) | `>= 840px` | Native landscape threshold |

Design sizes from Figma:
- Mobile: `375 x 812`
- Tablet: `768 x 1024`
- Web: `1440 x 960`

## Scaling Extensions

### `.r` — Standard responsive scaling

Use for all normal dimensions: spacing, padding, border radius, icon sizes.

```dart
16.wBox          // width spacer
context.paddingAll(16)  // padded container
12.radius        // border radius
```

### `.clampedR` — Clamped responsive scaling

Use for large structural dimensions (feature cards, dashboard panels, wide containers). Prevents blow-up on 4K/ultra-wide monitors by capping upscale at 110% of design size.

```dart
400.clampedR     // structural width
```

### Avoid Double Scaling

If a utility method already applies `.r` internally (like `context.getDefaultPadding()`), do NOT apply `.r` again on the result:

```dart
// Wrong — double-scaled
context.getDefaultPadding().r

// Correct
context.getDefaultPadding()
```

## Fixed-Size UI (Bypassing `.r`)

For structural elements that must not scale (sidebars, app bars, tooltips, floating panels), use `isResponsive: false` on `CustomText` and raw pixel values:

```dart
CustomText(
  'Sidebar Label',
  fontSize: 14,          // raw px, NOT 14.sp
  isResponsive: false,   // disables .sp/.r scaling
)
```

Sidebar widths are fixed: `221px` extended, `72px` collapsed. They auto-collapse below `1200px` screen width.

## Device-Specific Values

Use `context.valueWhenDevice` to provide per-device-type values:

```dart
context.valueWhenDevice(
  mobile: 12.0,
  tablet: 14.0,
  desktop: 16.0,
)
```

## Context Helpers

| Helper | Description |
|---|---|
| `context.isAppLandscape` | Layout branch (landscape vs portrait) |
| `context.isAppPortrait` | Inverse of above |
| `context.deviceType()` | Returns `DeviceType.mobile/tablet/desktop` |
| `context.isMobile` / `isTablet` / `isDesktop` | Device checks |
| `context.getDefaultPadding()` | Platform-aware default padding (already `.r` scaled) |
| `context.getDefaultRadius()` | Platform-aware border radius (already `.r` scaled) |
| `context.getDefaultGap()` | Standard gap (`12.r`) |
| `context.getIconSize()` | Accessible icon size |
| `context.screenWidth` / `screenHeight` | Current screen dimensions |
| `context.currentDesignSize` | Active Figma design reference size |

## Page-Level Composition Pattern

```
view/
├── feature_view.dart          # CustomResponsiveBuilder, scaffold, title
├── components/
│   ├── feature_portrait.dart  # Portrait layout composition
│   └── feature_landscape.dart # Landscape layout composition
└── widgets/
    └── ...                    # Shared feature widgets
```

Keep responsive branching at the page level (`view/` and `components/`), not buried inside individual field widgets.

## Anti-Patterns

- Using `context.isLandscape` instead of `context.isAppLandscape`
- Applying `.r` on already-scaled helper results (double scaling)
- Using `MediaQuery.of(context).size.width` directly instead of responsive extensions
- Placing responsive layout branching deep inside shared form widgets
- Using `.sp` for structural elements that should remain fixed-size
- Hardcoding breakpoints instead of using `ResponsiveConfig` constants
