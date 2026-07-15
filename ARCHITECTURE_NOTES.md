# Architecture Notes

This document explains the architectural decisions made during the implementation of this project, the reasoning behind them, the trade-offs considered, and the current limitations of the Proof of Concept.

---

# Project Goal

The goal of this project was **not** to build a production-ready application.

Instead, the objective was to create a small Proof of Concept (PoC) demonstrating how a Flutter project can migrate from GetX to Cubit while preserving a clean, scalable architecture similar to the one used in enterprise projects.

The focus was placed on:

- Clean Architecture
- Separation of concerns
- Feature-first organization
- Maintainability
- Reusability
- Consistent state management
- Decoupled navigation

---

# Why Cubit?

Cubit was selected instead of GetX because it provides a more explicit and predictable state management approach.

Advantages include:

- Explicit state transitions
- Better separation between UI and business logic
- Easier debugging
- Easier unit testing
- Recommended Flutter ecosystem solution
- Large community support

Although Cubit introduces more boilerplate than GetX, the architecture becomes significantly easier to maintain as the project grows.

---

# Why Clean Architecture?

The project follows a simplified Clean Architecture approach.

The application is divided into clear responsibilities:

```
Presentation

↓

Repository

↓

Datasource

↓

Network
```

This separation makes each layer responsible for a single concern.

Benefits include:

- easier maintenance
- easier testing
- reusable infrastructure
- reduced coupling

---

# Why Feature-first Structure?

Instead of organizing files by type (pages, widgets, models...), the project is organized by feature.

Example:

```
features/
    posts/
        data/
        presentation/
```

Advantages:

- Better scalability
- Easier onboarding
- Features remain isolated
- Easier code ownership
- Lower merge conflicts

Adding a new feature requires minimal impact on existing modules.

---

# Why Repository Pattern?

Repositories provide an abstraction between the Presentation layer and the Data layer.

Instead of depending on networking code directly, Cubits depend only on an abstract repository.

Benefits:

- Easier testing
- Easier mocking
- Datasource implementation can change without affecting UI
- Business logic remains independent from networking

---

# Why Datasource Abstraction?

Each repository depends on an abstract datasource instead of directly using Dio.

Responsibilities of a datasource:

- call APIs
- receive raw responses
- convert JSON into API models

Keeping networking inside datasources prevents HTTP logic from leaking into repositories or Cubits.

---

# Why Separate API Models and UI Models?

API models represent the backend contract.

UI models represent what the presentation layer actually needs.

For example:

```
ApiPost

↓

Mapper

↓

Post
```

This separation provides several advantages:

- Backend changes do not affect the UI directly.
- UI models can expose computed properties.
- UI models remain independent from serialization.

---

# Why Mapper Classes?

Mappers provide a single location responsible for converting API models into UI models.

Without mappers, conversion logic would be duplicated across repositories.

Benefits:

- Single responsibility
- Easier testing
- Cleaner repositories
- Better readability

---

# Why RequestHelper?

Without RequestHelper, every Cubit would contain identical code:

- emit loading
- try
- catch
- ErrorHandler
- emit success
- emit failure

This results in unnecessary duplication.

RequestHelper centralizes that workflow into one reusable implementation.

Advantages:

- thinner Cubits
- consistent state transitions
- centralized error handling
- easier maintenance

---

# Why DataStateBuilderWidget?

Almost every screen follows the same rendering flow:

Loading

↓

Success

↓

Empty

↓

Failure

Instead of repeating that logic in every page, the project introduces a reusable DataStateBuilderWidget.

Benefits:

- consistent UI
- less duplicated code
- reusable across all features

---

# Why GetIt?

GetIt was selected because:

- lightweight
- no code generation
- easy to understand
- simple setup

The project intentionally avoids code generation libraries such as Injectable to keep the PoC simple.

---

# Why GoRouter?

GoRouter was selected because it is the recommended routing solution for modern Flutter applications.

It supports:

- named routes
- path parameters
- deep linking
- declarative routing

---

# Why Contextless Navigation?

Navigation is centralized inside AppNavigation.

Pages never call:

```
Navigator.push()

context.push()

context.go()
```

Instead they simply call:

```dart
AppNavigation.toPostDetails(id: post.id);
```

Advantages:

- feature layer does not know GoRouter
- navigation implementation can change without touching features
- cleaner architecture
- improved maintainability

---

# Why Page-scoped Cubits?

Cubits are registered as Factory objects inside GetIt.

Each page creates its own Cubit instance and disposes it when leaving the screen.

Advantages:

- no stale state
- predictable lifecycle
- lower memory usage
- better encapsulation

---

# Why Request State Objects?

Each Cubit exposes explicit states:

- Initial
- Loading
- Success
- Failure

This provides a predictable state machine that is easy to understand and debug.

---

# Trade-offs

To keep the project focused on architecture, several production features were intentionally omitted.

These include:

- Authentication
- Pagination
- Offline storage
- Local database
- Notifications
- Analytics
- Localization
- Theme switching
- Domain layer / UseCases

Adding those features would increase the project complexity without contributing to the architectural objective of the PoC.

---

# Current Limitations

The current implementation intentionally keeps the infrastructure lightweight.

Known limitations include:

- No unit tests
- No widget tests
- No integration tests
- NetworkService currently supports only GET requests
- No authentication flow
- No caching
- No retry mechanism
- No pagination
- No responsive layouts
- No localization

Additionally, although CancelToken is supported across the networking layer, Cubits currently do not create or cancel request tokens during disposal.

---

# Production Improvements

If this project were to evolve into a production application, the next priorities would be:

1. Add CancelToken management inside Cubits.
2. Add unit tests.
3. Expand NetworkService to support POST, PUT, PATCH and DELETE.
4. Add authentication.
5. Add token interceptors.
6. Add pagination.
7. Add local caching.
8. Add CI/CD.
9. Add localization.
10. Add responsive layouts.

---

# Architectural Decisions Summary

| Decision | Reason |
|----------|--------|
| Cubit | Predictable state management |
| GetIt | Lightweight dependency injection |
| GoRouter | Declarative routing |
| Repository Pattern | Decouple business logic from networking |
| Datasource Layer | Isolate HTTP implementation |
| API/UI Models | Decouple backend from presentation |
| Mapper Layer | Centralize model conversion |
| RequestHelper | Eliminate duplicated request handling |
| DataStateBuilderWidget | Reusable UI state rendering |
| Contextless Navigation | Decouple features from routing implementation |
| Feature-first Structure | Improve scalability and maintainability |

---

# Final Notes

The project successfully demonstrates that Cubit can replace GetX while preserving an enterprise-style architecture.

Although intentionally simplified, the overall structure is designed to scale as additional features are introduced.

The main objective was not to build a feature-rich application, but to establish a maintainable architectural foundation that can be extended in future projects with minimal structural changes.