# Icons & Splash Screen

To rebrand a new project from this boilerplate:

1. **Replace the logo**: swap in your artwork at `assets/images/logo.png` (used as the single source image for both launcher icons and the native splash).
2. **Launcher icons** — tune `flutter_launcher_icons.yaml` if needed (background/theme colors, `min_sdk_android`), then regenerate:

   ```sh
   dart run rps icons
   ```

   The current config already covers, out of the box:
   - Standard Android + iOS icons.
   - **Android 12+ themed icons**: `adaptive_icon_background`, `adaptive_icon_foreground`, and `adaptive_icon_monochrome` (the monochrome layer Android 13+ uses for tinted/themed home-screen icons).
   - **iOS 18+ dark and tinted icon variants**: `image_path_ios_dark_transparent` and `image_path_ios_tinted_grayscale` (with `desaturate_tinted_to_grayscale_ios: true`), so the icon looks correct in iOS's dark-mode and tinted-mode home screens.
   - A web icon set (`web.generate: true`), used by `web/manifest.json`.

3. **Native splash (Android/iOS only)** — tune the `flutter_native_splash:` block in `pubspec.yaml` (background color, `android_12:` themed-splash overrides), then regenerate:

   ```sh
   dart run rps splash
   ```

   Web is intentionally excluded (`web: false`) — see [Web Deployment](web-deployment.md#the-bilingual-loading-screen) for why.

Continue to [Web Deployment](web-deployment.md).
