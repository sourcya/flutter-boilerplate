# Sourcya Flutter Boilerplate

A generic, production-ready Flutter starter for Android, iOS, and Web — built by Sourcya as the base for new client apps. It ships with navigation, dependency injection, networking, theming, localization (English/Arabic), a responsive UI kit, and a fully worked reference feature (`Products`) so a new project starts from working, idiomatic code instead of a blank `main.dart`.

> **Copy this repository to start a new product, then add your product's features on top of it. Do not add business logic from other Sourcya products (e.g. Madaan/TMT) into this boilerplate.**

## What's in these docs

- **[Tech Stack & Setup](getting-started.md)** — what's under the hood, and how to bootstrap a new project from this template.
- **[Project Structure](project-structure.md)** — how `lib/` is organized and why.
- **Architecture** — one page per topic ([design principles](architecture-overview.md), [dependency injection](dependency-injection.md), [navigation](navigation.md), [state management](state-management.md), [networking](networking.md), [error handling](error-handling.md), [UI components](ui-components.md), [responsive layout](responsive-layout.md), [localization](localization.md), [view splitting](view-splitting.md)) — each grounded in the real, working reference feature at `lib/app/products/`.
- **[Building a New Feature](building-a-feature.md)** — the exact step-by-step sequence to add a feature like Products.
- **[Agent Skills Reference](skills-reference.md)** — the machine-readable rules behind this guide, at `.agent/skills/` (mirrored in `.cursor/skills/`).
- **[Environment Variables](environment-variables.md)**, **[Icons & Splash Screen](icons-and-splash.md)**, **[Web Deployment](web-deployment.md)**, **[Codemagic / CI](codemagic-ci.md)**, and a **[Commands Reference](commands-reference.md)**.

Use the sidebar to navigate, or the search box at the top.

## Quick start

```sh
git clone <your-new-repo-url>
cd <your-new-repo>
flutter pub get
dart run rps setup
```

See [Tech Stack & Setup](getting-started.md) for the full walkthrough, including renaming the app, rebranding icons/splash, and configuring environment variables.
