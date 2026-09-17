---
name: core-architecture
description: Guidelines for managing Core App configurations like Navigation (Routes) and Preferences (Storage).
---

# Core Architecture

The `lib/core/` directory contains cross-cutting foundational services. 

## 🧭 Navigation (`lib/core/navigation/`)

This project implements routing using the `playx_navigation` package (a thin wrapper around `go_router` or `get_navigation` depending on project setup, typically `GoRouter` semantics).

**Key Rules:**
1. **Never use raw strings for routing in views.**
2. **`app_routes.dart`**: Always define `Routes` standard constants and `Paths` raw string constants here.
3. **`app_navigation.dart`**: Create strongly typed static methods for EVERY navigation action.
   - Example: `static void navigateToDriverDetails({required TaxiDriver driver})`
   - Use `PlayxNavigation.toNamed(...)`, `offAllNamed(...)`, `pop()`.
   - Pass strongly-typed arguments via the `extra` parameter.
   - Pass string arguments or route dynamic IDs via `pathParameters` or `queryParameters`.

## 💾 Preferences (`lib/core/preferences/`)

A centralized mechanism for local storage handled by `MyPreferenceManger`.

**Key Rules:**
1. **Encapsulation**: Treat `MyPreferenceManger` as the single source of truth for key-value local storage. Do not use `SharedPreferences` directly in your code.
2. **Synchronous vs Asynchronous**: Native Flutter SharedPrefs might be async, ensure getter/setters use `PlayxPrefs` properly (usually synchronous `PlayxPrefs.getString()` or `PlayxAsyncPrefs` if required).
3. **Security**: For sensitive data like auth tokens, passwords, and user information, `MyPreferenceManger` uses `PlayxSecurePrefs`.
  - Token -> `saveToken(String jwt)`
  - Credentials -> `saveUserCredentials(...)`
4. **App Settings**: General non-sensitive UI traits like Theme, onboarding flags, and remember-me are stored plainly with `PlayxPrefs`.
