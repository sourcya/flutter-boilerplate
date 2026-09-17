# Architecture: Design Principles & Feature Anatomy

The concrete rules across this Architecture section are also encoded as [agent skills](skills-reference.md) under `.agent/skills/` (mirrored in `.cursor/skills/` for Cursor) — these pages are the human-readable narrative version of the same rules, grounded in the real reference feature at `lib/app/products/`.

## Design principles

- **Separation of concerns**: widgets only render; business logic lives in controllers/repositories, never inline in a `build()` method.
- **Single source of truth (SSOT) + unidirectional data flow**: each piece of app data has one owner (a repository or controller) that exposes it immutably; events flow up from the UI to that owner, state flows back down. This is why controllers expose `Rx`/`DataState` fields instead of mutable public fields the view can write to directly.
- **UI layer vs. data layer**: every feature has a UI layer (`view` + `controller` + `binding`) that renders data and reacts to user input, and a data layer (`datasource` + `repository` + `model`) that owns fetching, caching, and business rules. The UI layer never talks to a datasource directly — always through a repository.

## Feature folder anatomy

Every feature under `lib/app/<feature>/` follows this shape (see `.agent/skills/feature-architecture/SKILL.md`):

```text
lib/app/<feature>/
├── data/
│   ├── datasource/    # Abstract <Feature>Datasource + <Feature>DatasourceImpl, uses PlayxNetworkClient
│   ├── repository/    # Abstract <Feature>Repository + <Feature>RepositoryImpl, bridges NetworkResult -> UI models
│   └── model/
│       ├── api/       # ApiX — raw JSON, all fields nullable, fromJson()/toJson()
│       ├── ui/        # UiX — immutable, Equatable, non-nullable with defaults, copyWith()
│       └── mapper/    # extension ApiXMapper on ApiX { Product toUi() }, list variants
├── ui/
│   ├── view/          # Stateless views built on CustomScaffold
│   ├── controller/    # GetxController (or BasePagedController<T> for paginated lists)
│   ├── binding/       # PlayxBinding — DI lifecycle for this route
│   └── imports/       # One barrel file per module, wires `part`/`part of`
```

`lib/app/products/` is the concrete, working instance of this shape:

- `data/datasource/products_datasource.dart` — `ProductsDatasource` (abstract) / `ProductsDatasourceImpl`
- `data/repository/products_repository.dart` — `ProductsRepository` (abstract) / `ProductsRepositoryImpl`
- `data/model/api/api_product.dart`, `api_product_page.dart` — `ApiProduct`, `ApiProductPage`
- `data/model/ui/product.dart` — `Product` (`Equatable`, `copyWith`)
- `data/model/mapper/product_mapper.dart` — `ApiProductMapper` / `ApiProductListMapper` extensions
- `ui/controller/products_controller.dart`, `ui/binding/products_binding.dart`, `ui/view/products_view.dart`, `ui/view/widgets/product_grid_tile_widget.dart` / `product_list_tile_widget.dart`

Data flow, end to end:

```
API JSON → ApiProduct.fromJson() → ProductsDatasource → ProductsRepository (mapDataAsyncInIsolate) → Product (UI model) → ProductsController → ProductsView
```

For features with overlapping create/edit/details flows (not a plain list like Products), use the `crud-feature-architecture` skill instead — it defines dedicated `create_x/`, `edit_x/`, `x_form/`, and optional `x_details/` modules with strict controller-ownership rules.

Continue to [Dependency Injection](dependency-injection.md) for how each layer gets wired together.
