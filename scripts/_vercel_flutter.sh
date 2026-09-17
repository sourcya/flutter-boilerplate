# Resolves $FLUTTER_COMMAND to a usable `flutter` binary, installing the
# stable SDK into $FLUTTER_SDK_DIR if one isn't already available on PATH.
#
# Sourced by scripts/vercel_install.sh and scripts/vercel_build.sh (which run
# as separate Vercel build-lifecycle steps, so neither can rely on the
# other's shell state) — not meant to be run directly.

FLUTTER_SDK_DIR="${FLUTTER_SDK_DIR:-.vercel_flutter}"

if command -v flutter >/dev/null 2>&1; then
  FLUTTER_COMMAND="$(command -v flutter)"
elif [[ -x "flutter/bin/flutter" ]]; then
  FLUTTER_COMMAND="flutter/bin/flutter"
elif [[ -x "$FLUTTER_SDK_DIR/bin/flutter" ]]; then
  FLUTTER_COMMAND="$FLUTTER_SDK_DIR/bin/flutter"
else
  echo "Installing the Flutter stable SDK..."
  git clone --depth 1 --branch stable https://github.com/flutter/flutter.git "$FLUTTER_SDK_DIR"
  FLUTTER_COMMAND="$FLUTTER_SDK_DIR/bin/flutter"
fi
