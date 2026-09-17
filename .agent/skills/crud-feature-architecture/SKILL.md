---
name: crud-feature-architecture
description: Specialized architecture guide for Flutter features that include create, edit, optional details, and shared form flows with clear controller ownership and route boundaries.
---

# CRUD Feature Architecture

Use this skill when building a user-facing feature that has overlapping create/edit form behavior and needs predictable page ownership, route safety, and reusable form logic.

Also follow these repo-local skills alongside this one:
- `feature-architecture`
- `navigation-architecture`
- `dependency-injection`

This skill does not replace those guides. It narrows them for features that include:
- a create flow
- an edit flow
- a shared form module
- an optional details flow when the product supports read-only details

Do not use this skill for:
- read-only list-only features
- tiny one-off forms that are unlikely to grow
- features where create and edit do not meaningfully overlap

## Purpose

This architecture keeps:
- page-level logic isolated
- shared form logic reusable
- read-only flows independent when supported
- navigation predictable
- controller ownership clear
- responsive composition easy to maintain

Use it when a feature needs long-term structure, not just a quick form page.

## Required Folder Structure

Each user-facing flow should live in its own dedicated top-level feature folder under the parent feature UI module.

```text
lib/app/<feature>/ui/
├── create_x/
│   ├── binding/
│   ├── controller/
│   ├── imports/
│   └── view/
│       ├── components/
│       └── widgets/
├── edit_x/
│   ├── binding/
│   ├── controller/
│   ├── imports/
│   └── view/
│       ├── components/
│       └── widgets/
├── x_form/
│   ├── controller/
│   ├── imports/
│   └── view/
│       └── widgets/
└── x_details/
    ├── binding/
    ├── controller/
    ├── imports/
    └── view/
        ├── components/
        └── widgets/
```

If details is not supported yet, stop at:

```text
lib/app/<feature>/ui/
├── create_x/
├── edit_x/
└── x_form/
```

Do not create `x_details` until the product actually supports a read-only details flow.

## Responsibilities By Module

### `create_x`

Responsible for:
- creating new entities
- page-level flow
- navigation handling
- create submit action
- create-specific UI

Expected structure:
- `binding/`
  - registers `CreateXController`
- `controller/`
  - extends `XFormController`
  - implements `createX()`
- `view/`
  - owns scaffold/page shell
  - owns title, back behavior, breadcrumbs, and responsive composition
- `view/widgets/`
  - create-only action bars, success states, confirmation blocks, or wrappers

### `edit_x`

Responsible for:
- editing existing entities
- prefilling form state
- update submit action
- edit-specific page behavior

Expected structure:
- `binding/`
  - resolves entity from route `extra` or route params
  - registers `EditXController`
- `controller/`
  - extends `XFormController`
  - owns prefill logic
  - implements `editX()`
- `view/`
  - reuses the same shell pattern as create
  - uses edit-specific titles and actions
- `view/widgets/`
  - update bars, edit status UI, or edit-only actions

### `x_form`

Shared reusable form module between create and edit.

Responsible for:
- shared field controllers
- validation
- shared form state
- dropdown/data loaders used by both flows
- picker/file/map helpers used identically by both flows
- payload builders and reusable form helpers

Expected structure:
- `controller/`
  - contains shared state and validation
  - contains shared helper methods
  - may expose `buildPayload()`, `buildCreateRequest()`, or `buildUpdateRequest()` helpers
- `view/widgets/`
  - contains reusable form sections and shared field widgets only

This module must not own:
- page-level navigation
- final create submit flow
- final edit submit flow
- create-specific actions
- edit-specific actions
- entity prefill logic

Unless a piece of behavior is truly identical across both flows, keep it out of `x_form`.

### `x_details`

Create this module only when read-only details are actually supported.

Responsible for:
- rendering read-only entity information
- refreshing entity data
- exposing details-only actions
- navigation to edit/delete when supported

Expected structure:
- `binding/`
  - resolves selected entity
  - registers `XDetailsController`
- `controller/`
  - loads and refreshes entity data
  - exposes details actions such as edit, delete, toggle status, or refresh
- `view/`
  - owns read-only details screen structure
- `view/widgets/`
  - header cards, info rows, media/map blocks, action rows, or tabs

If details is not part of the product yet, omit this module completely instead of creating a placeholder implementation.

## Controller Ownership Rules

Keep controller boundaries strict.

### Shared form logic belongs only in `x_form/controller`

Includes:
- text/editing controllers
- form keys
- validation state
- shared workers/listeners
- dropdown selections
- shared field helpers
- shared payload builders

### Create submission logic belongs only in `CreateXController`

Includes:
- create API submission
- create success handling
- list refresh after creation
- create-specific analytics or side effects

Do not place final create submission inside `XFormController`.

### Edit submission and prefill logic belong only in `EditXController`

Includes:
- entity prefill
- edit API submission
- update success handling
- list refresh after update

Do not place prefill logic inside `XFormController`.

### Details actions belong only in `XDetailsController`

When details is supported, keep read-only actions there:
- refresh
- edit navigation
- delete
- toggle status

Do not merge details responsibilities into create or edit controllers.

### Anti-patterns to avoid

Do not ship a combined controller that owns all of:
- shared form state
- create submit
- edit submit
- prefill
- details rendering/actions
- modal navigation APIs

Split these responsibilities before the feature grows further.

## Navigation And Binding Rules

All feature routes must be declared in:
- `lib/core/navigation/src/app_routes.dart`

All feature route wiring must be declared in:
- `lib/core/navigation/src/app_pages.dart`

All feature navigation APIs must be exposed through:
- `lib/core/navigation/src/app_navigation.dart`

### Required routes

For features using this architecture, define dedicated routes for:
- create
- edit
- details when supported

Examples:
- `Routes.createX`
- `Routes.editX`
- `Routes.xDetails`

Examples:
- `Paths.createX`
- `Paths.editX`
- `Paths.xDetails`

### Binding rules

Each route must have its own `PlayxBinding`:
- `CreateXBinding`
- `EditXBinding`
- `XDetailsBinding` when applicable

Bindings should:
- resolve route data safely
- register the correct route-scoped controller
- clean up controller ownership on exit

### Navigation rules

Never call raw `PlayxNavigation.toNamed()` directly from view widgets.

Always add strongly typed helper methods to `AppNavigation`, for example:

```dart
static void navigateToCreateX() {}
static void navigateToEditX({required X entity}) {}
static void navigateToXDetails({required X entity}) {}
```

Do not use controller-owned modal navigation APIs as the architectural default.

Modal presentation can still exist as a product decision, but it should not replace:
- proper route declarations
- proper bindings
- proper typed navigation APIs

## Imports Rules

Use one imports entrypoint per top-level feature module.

Examples:
- `create_x/imports/create_x_imports.dart`
- `edit_x/imports/edit_x_imports.dart`
- `x_form/imports/x_form_imports.dart`
- `x_details/imports/x_details_imports.dart`

Rules:
- keep each imports file scoped to its own module
- gather imports, `part`, and `part of` declarations there
- do not keep one giant imports file spanning list, create, edit, form, and details forever

The shared form module must always expose its own imports entrypoint.

## Responsive UI Rules

Keep responsive composition at the page level, not buried in field widgets.

### `view/`

Owns:
- scaffold/page shell
- title
- breadcrumbs
- page-level spacing
- high-level responsive orchestration

### `view/components/`

Owns:
- portrait layout composition
- landscape layout composition
- reusable page sections tied to orientation or shell structure

### `view/widgets/`

Owns:
- feature-specific action bars
- submit footers
- success blocks
- edit-only or create-only UI elements

### `x_form/view/widgets/`

Owns:
- reusable form sections only
- shared input rows
- shared dropdown widgets
- shared picker sections

Do not place page-level responsive branching inside the shared form module unless the behavior is truly shared between create and edit.

## Validation Checklist

Every feature using this architecture should validate the following scenarios.

### Create flow

- empty/default form state renders correctly
- validation works
- submission succeeds
- parent list refreshes after creation

### Edit flow

- existing entity preloads correctly
- shared validation behaves correctly
- updates submit successfully
- parent list refreshes after update

### Shared form

- shared widgets behave consistently
- validation rules remain reusable
- state synchronization works correctly

### Details flow when present

- entity renders correctly
- actions function correctly
- edit/delete navigation works
- refresh behaves correctly

### Route safety

- missing route data fails safely
- invalid entity states are handled gracefully

### Responsive layouts

- portrait layouts render correctly
- landscape layouts render correctly
- web/tablet layouts behave correctly

## Implementation Notes

### When migrating an older combined flow

If the feature currently has one controller that mixes:
- shared form state
- create submit
- edit submit
- prefill
- details behavior

Refactor in this order:

1. Extract shared form state into `x_form/controller/XFormController`
2. Move shared field widgets into `x_form/view/widgets`
3. Create `CreateXController` for create-only submission
4. Create `EditXController` for prefill and update-only submission
5. Move page shells into `create_x/view` and `edit_x/view`
6. Add typed `AppNavigation` methods and dedicated routes
7. Add `x_details` only if the product supports details

### When details is unsupported

If the feature does not support read-only details yet:
- do not create a placeholder `x_details` module
- do not add unused details routes
- keep the architecture at `create_x`, `edit_x`, and `x_form`
- add `x_details` only when the product requires it

### Default architectural expectation

For any new feature with overlapping create/edit behavior, prefer this structure from the beginning instead of waiting for the feature to become hard to untangle later.
