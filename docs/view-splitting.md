# View Splitting

Once a view file grows past ~150–200 lines, or accumulates `_buildX()` helper methods, split it into focused `StatelessWidget` files connected by `part`/`part of` through the feature's imports barrel — this is exactly the mechanism `products_imports.dart` uses:

```dart
// lib/app/products/ui/imports/products_imports.dart
part '../binding/products_binding.dart';
part '../controller/products_controller.dart';
part '../view/products_view.dart';
part '../view/widgets/product_grid_tile_widget.dart';
part '../view/widgets/product_list_tile_widget.dart';
```

Every extracted file starts with `part of '../../imports/products_imports.dart';`. Rules of thumb:

- One widget class per file.
- Pass data through the constructor rather than reaching into a shared controller when the widget doesn't need reactivity.
- Keep the top-level `*_view.dart` down to scaffold + composition (no `_build` methods, no responsive branching logic beyond delegating to a portrait/landscape component).

This wraps up the Architecture section. Continue to [Building a New Feature, Step by Step](building-a-feature.md) to see all of this applied end to end.
