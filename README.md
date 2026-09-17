# Sourcya Flutter Boilerplate

A generic, production-ready Flutter starter for Android, iOS, and Web — built by Sourcya as the base for new client apps. It ships with navigation, dependency injection, networking, theming, localization (English/Arabic), a responsive UI kit, and a fully worked reference feature (`Products`) so a new project starts from working, idiomatic code instead of a blank `main.dart`.

**Copy this repository to start a new product, then add your product's features on top of it. Do not add business logic from other Sourcya products (e.g. Madaan/TMT) into this boilerplate.**

## 📖 Full documentation

The full guide — architecture, every convention, the agent skills reference, deployment — lives in [`docs/`](docs/README.md) as a [docsify](https://docsify.js.org/) site (no build step; open `docs/index.html` directly, run it locally, or deploy it):

```sh
npx serve docs   # or: cd docs && python3 -m http.server 8080
```

When deployed (see [docs/web-deployment.md](docs/web-deployment.md)), the same Vercel project serves the docs at `/docs` alongside the Flutter web app at `/`.

| | |
|---|---|
| 🚀 [Getting Started](docs/getting-started.md) | Tech stack, setup script, running the app |
| 🗂 [Project Structure](docs/project-structure.md) | How `lib/` is organized |
| 🏗 [Architecture](docs/architecture-overview.md) | Feature anatomy, DI, navigation, state, networking, error handling, UI, responsive layout, localization, view splitting |
| 🧩 [Building a New Feature](docs/building-a-feature.md) | Step-by-step, using `Products` as the worked example |
| 🧠 [Agent Skills Reference](docs/skills-reference.md) | The rules behind this guide, under `.agent/skills/` |
| 🔑 [Environment Variables](docs/environment-variables.md) | `.env` setup |
| 🎨 [Icons & Splash Screen](docs/icons-and-splash.md) | Rebranding a new project |
| 🌐 [Web Deployment](docs/web-deployment.md) | Vercel (app + docs, one project), the bilingual loading screen |
| 🤖 [Codemagic / CI](docs/codemagic-ci.md) | Build workflows |
| ⌨️ [Commands Reference](docs/commands-reference.md) | Every `dart run rps <name>` script |

## Quick start

```sh
git clone <your-new-repo-url>
cd <your-new-repo>
flutter pub get
dart run rps setup
flutter run -d chrome
```

See [docs/getting-started.md](docs/getting-started.md) for the full walkthrough.
