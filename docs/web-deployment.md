# Web Deployment

Build the release web bundle with:

```sh
dart run rps build-web
```

This runs `flutter build web --release`.

## The bilingual loading screen

`web/index.html` ships a bespoke, animated loading screen (styled by `web/loader_styles.css`) that renders **before** the Flutter engine has even initialized. It:

- Detects the browser's language (`navigator.language`) and shows English or Arabic copy accordingly, setting `dir="rtl"` for Arabic.
- Progresses through "Preparing…" → "Starting…" → "Opening your workspace…" status text as `_flutter.loader.load()`'s `onEntrypointLoaded` callback advances.
- Falls back to a translated error message if `engineInitializer.initializeEngine()` or `appRunner.runApp()` throws.
- Is accessible: `role="status"`, `aria-live="polite"`, `aria-busy` toggling, and a `<noscript>` fallback message.

Because of this, **native splash (`flutter_native_splash`) is deliberately excluded from web** (`web: false` in the `flutter_native_splash:` block of `pubspec.yaml`) — a native splash on web would just be a redundant overlay stacked underneath the custom loader that never gets dismissed.

`web/manifest.json` provides standard PWA metadata (name, theme color `#14213D`, standard + maskable icons at 192/512px).

## Deploying to Vercel

`vercel.json` at the repo root drives the deployment:

```json
{
  "buildCommand": "bash scripts/vercel_build.sh",
  "outputDirectory": "build/web"
}
```

`scripts/vercel_build.sh` installs/locates a Flutter SDK, writes `assets/env/keys.env` from the `ENVIRONMENT_KEY` (or legacy `ENVIROMENT_KEY`) project variable, runs `flutter build web --release`, **and then copies this `docs/` folder into `build/web/docs/`** so a single Vercel deployment serves both:

- `/` — the Flutter web app (SPA rewrite: any path that isn't `/docs` or `/docs/*` falls back to `/index.html`, per the `rewrites` rule in `vercel.json`).
- `/docs` — this documentation site (docsify — a client-side markdown renderer, no build step; it's just static files served as-is).

To set this up on Vercel:

1. Push this repo to GitHub/GitLab/Bitbucket and import it in the Vercel dashboard (or run `vercel link` locally if you have the CLI installed and are logged in) — Vercel auto-detects `vercel.json`, no framework preset needed.
2. Set the `ENVIRONMENT_KEY` project environment variable to the full contents of your `assets/env/keys.env` file.
3. Deploy. `/` serves the app, `/docs` serves these docs, both from the same project/domain.

You can verify the split locally before deploying, without any Vercel account:

```sh
flutter build web --release
cp -R docs build/web/docs
cd build/web && python3 -m http.server 8080
# http://localhost:8080/      -> the Flutter app
# http://localhost:8080/docs/ -> this documentation site
```

Codemagic has a separate `web-workflow` (see [Codemagic / CI](codemagic-ci.md)) that runs analysis, conditional tests, and produces a release web build artifact — it does not currently publish to Vercel or bundle `docs/`.

Continue to [Codemagic / CI](codemagic-ci.md).
