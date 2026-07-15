# Flutter UI Boilerplate

A Flutter Proof of Concept (PoC) demonstrating a scalable **feature-first Clean Architecture** using **Cubit (flutter_bloc)** as an alternative to GetX.

The project showcases how enterprise architecture can be built using Flutter with a clean separation of concerns while keeping the codebase simple and maintainable.

---

# Features

- Posts List
- Post Details
- Pull-to-refresh
- Platform-adaptive loading indicators
- Error handling with retry
- Empty state handling
- Dark / Light theme (System)
- Contextless navigation using GoRouter

---

# Tech Stack

- Flutter
- Dart
- flutter_bloc (Cubit)
- Dio
- GetIt
- GoRouter
- Equatable

---

# Architecture

The project follows a **feature-first Clean Architecture**.

```
Presentation
    │
    ▼
Repository
    │
    ▼
Datasource
    │
    ▼
NetworkService
    │
    ▼
Dio
```

Each feature is completely isolated and contains its own:

- Presentation
- Data
- Repository
- Models
- Mapper

---

# Project Structure

```
lib
├── app
│   ├── app.dart
│   ├── di
│   └── navigation
│
├── core
│   ├── constants
│   ├── data_state
│   ├── extensions
│   ├── network
│   ├── services
│   ├── utils
│   └── widgets
│
└── features
    └── posts
        ├── data
        └── presentation
```

---

# State Management

The project uses **Cubit** from `flutter_bloc`.

Each page owns its Cubit lifecycle.

```
Page
   ↓
Cubit
   ↓
Repository
   ↓
Datasource
   ↓
NetworkService
```

Cubits remain thin by delegating request execution to **RequestHelper**.

---

# Networking

Networking is built on top of **Dio**.

The flow is:

```
Cubit
   ↓
Repository
   ↓
Datasource
   ↓
NetworkService
   ↓
Dio
```

NetworkService is responsible for:

- Executing requests
- Mapping responses
- Status validation
- CancelToken support

---

# Dependency Injection

Dependency injection is implemented using **GetIt**.

Object lifecycle:

- LazySingleton
    - Dio
    - NetworkService
    - Datasources
    - Repositories

- Factory
    - Cubits

This ensures every page receives its own Cubit instance while infrastructure services remain shared.

---

# Navigation

Navigation is implemented using **GoRouter**.

Feature code never imports GoRouter directly.

All navigation is centralized inside:

```
app/navigation/app_navigation.dart
```

Example:

```dart
AppNavigation.toPosts();

AppNavigation.toPostDetails(id: post.id);

AppNavigation.pop();
```

This keeps the navigation layer independent from feature modules.

---

# Request Flow

```
Page

↓

Cubit

↓

RequestHelper

↓

Repository

↓

Datasource

↓

NetworkService

↓

Dio

↓

API
```

Responses travel back through the same chain until the UI is rebuilt.

---

# Shared Infrastructure

The project contains reusable infrastructure components including:

- RequestHelper
- DataState
- DataStateBuilderWidget
- LoadingViewWidget
- ErrorViewWidget
- EmptyViewWidget
- ErrorHandler
- Safe JSON conversion utilities
- NetworkService

These components are intended to be reused across future features.

---

# Design Decisions

This project intentionally includes:

- Feature-first architecture
- Repository Pattern
- Datasource abstraction
- API/UI model separation
- Mapper layer
- Contextless navigation
- Thin Cubits
- Generic request execution
- Generic UI state builder

The following were intentionally excluded to keep the PoC focused:

- Authentication
- Pagination
- Offline cache
- Local database
- Localization
- Theme switching
- Notifications
- Domain layer / UseCases

---

# Current Features

Implemented:

- Fetch all posts
- View post details
- Pull-to-refresh
- Loading states
- Error states
- Empty states
- Dark / Light theme
- Contextless navigation

---

# Future Improvements

Potential production enhancements include:

- Authentication
- Token interceptor
- Unit tests
- Widget tests
- Integration tests
- Pagination
- Local caching
- Offline support
- Analytics
- Localization
- Responsive layouts
- CI/CD pipeline

---

# Code Quality

Current project status:

- ✅ Clean Architecture
- ✅ Feature-first structure
- ✅ Repository Pattern
- ✅ Cubit state management
- ✅ GoRouter navigation
- ✅ GetIt dependency injection
- ✅ Dio networking
- ✅ Zero analyzer issues

---

# Running the Project

Clone the repository and install dependencies:

```bash
flutter pub get
```

Run the application:

```bash
flutter run
```

Analyze the project:

```bash
flutter analyze
```

---

# Purpose

This project was created as an architecture Proof of Concept demonstrating how Cubit can replace GetX while preserving clean architecture principles and maintaining an enterprise-ready project structure.