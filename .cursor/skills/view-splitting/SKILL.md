---
name: view-splitting
description: Split large view files into compact, single-responsibility StatelessWidget files under view/widgets/ using the part/part of barrel pattern. Extract _build helper methods into standalone widgets.
---

# View Splitting

Split bloated view files into focused, compact StatelessWidget files. Every visual section should be its own widget file under `view/widgets/`, connected via `part`/`part of` through the feature's imports barrel.

## When to Apply

- A view file exceeds ~150–200 lines
- A view contains `_buildSomething()` helper methods that return widgets
- A single file defines multiple widget classes
- A view mixes page-level layout with section-level details

## Target Structure

```
lib/app/<feature>/ui/<module>/
├── imports/
│   └── <module>_imports.dart    # barrel: imports + part declarations
├── views/
│   └── <module>_view.dart       # page shell only (scaffold, layout branching)
│   └── components/              # portrait/landscape layout compositions
│   │   ├── <module>_portrait.dart
│   │   └── <module>_landscape.dart
│   └── widgets/                 # extracted focused widgets
│       ├── <name>_widget.dart
│       ├── <name>_section.dart
│       └── <name>_card.dart
├── controllers/
│   └── <module>_controller.dart
└── bindings/
    └── <module>_binding.dart
```

## Rules

### 1. Every extracted file uses `part of`

Each widget file starts with `part of` pointing to the imports barrel:

```dart
part of '../../imports/<module>_imports.dart';
```

And the barrel file declares each widget with `part`:

```dart
// <module>_imports.dart
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';
// ... other imports

part '../views/<module>_view.dart';
part '../views/widgets/<name>_widget.dart';
part '../views/widgets/<name>_section.dart';
part '../controllers/<module>_controller.dart';
part '../bindings/<module>_binding.dart';
```

### 2. Extract `_build` methods into StatelessWidgets

Any private `_buildX()` method returning a Widget must become its own class in a separate file.

**Before** (inside view file):
```dart
class DriversView extends GetView<DriversController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        _buildDriverList(context),
        _buildEmptyState(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row( /* 40 lines */ );
  }

  Widget _buildDriverList(BuildContext context) {
    return Expanded( /* 60 lines */ );
  }
}
```

**After** (split into files):

`views/drivers_view.dart`:
```dart
part of '../imports/drivers_imports.dart';

class DriversView extends GetView<DriversController> {
  const DriversView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DriversHeaderWidget(),
        const DriversListWidget(),
        const DriversEmptyStateWidget(),
      ],
    );
  }
}
```

`views/widgets/drivers_header_widget.dart`:
```dart
part of '../../imports/drivers_imports.dart';

class DriversHeaderWidget extends GetView<DriversController> {
  const DriversHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row( /* the extracted content */ );
  }
}
```

### 3. Naming conventions

| Source | Target file | Target class |
|---|---|---|
| `_buildHeader()` | `<feature>_header_widget.dart` | `<Feature>HeaderWidget` |
| `_buildDriverList()` | `driver_list_widget.dart` | `DriverListWidget` |
| `_buildInfoSection()` | `info_section_widget.dart` | `InfoSectionWidget` |
| Inline large widget tree | `<descriptive_name>_widget.dart` | `<DescriptiveName>Widget` |

- Use `_widget.dart` suffix for standalone widgets
- Use `_section.dart` suffix for logical sections of a page
- Use `_card.dart` suffix for card-based content blocks

### 4. Pass data through constructor, not controller access

If the `_build` method used local variables or parameters, pass them via constructor:

```dart
// Good — explicit dependency
class DriverItemWidget extends StatelessWidget {
  final Driver driver;
  final VoidCallback? onTap;

  const DriverItemWidget({super.key, required this.driver, this.onTap});
}
```

Use `GetView<XController>` only when the widget genuinely needs reactive controller access. Prefer plain `StatelessWidget` when data can be passed in.

### 5. Keep the page view as a thin shell

The main view file should only contain:
- Scaffold / page shell setup
- Top-level responsive branching (`context.isAppLandscape`)
- Composition of child widgets

It should NOT contain:
- Widget building logic
- Complex widget trees deeper than 2–3 levels
- `_build` helper methods
- Multiple class definitions

### 6. One widget class per file

Never define multiple public or private widget classes in the same file. Each gets its own file under `widgets/`.

**Exception**: Tiny private helper classes (<15 lines) tightly coupled to their parent widget can stay in the same file.

### 7. Update the imports barrel after splitting

After extracting, add every new file as a `part` in the imports barrel. The order convention is:

```dart
// Binding
part '../bindings/<module>_binding.dart';

// Controller
part '../controllers/<module>_controller.dart';

// Views
part '../views/<module>_view.dart';

// Components (layout compositions)
part '../views/components/<module>_portrait.dart';
part '../views/components/<module>_landscape.dart';

// Widgets (alphabetical)
part '../views/widgets/<name>_widget.dart';
```

## Checklist After Splitting

- [ ] Every new file has `part of` pointing to the correct imports barrel
- [ ] Every new file is declared as `part` in the imports barrel
- [ ] No `_build` methods remain in the main view file
- [ ] No file defines more than one widget class (except tiny private helpers)
- [ ] Main view file is under ~100 lines (scaffold + composition only)
- [ ] `flutter analyze` passes with no errors
- [ ] App compiles and runs correctly

## Anti-Patterns

- Leaving `_buildX()` methods in the view "because they're small" — extract them anyway for consistency
- Using top-level functions instead of StatelessWidget classes for extracted widgets
- Forgetting to add `part` declarations in the imports barrel after creating new files
- Creating widget files without `part of` (causes import resolution errors)
- Splitting into too-granular files (a 10-line Row doesn't need its own file — use judgment)
