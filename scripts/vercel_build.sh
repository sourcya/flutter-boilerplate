#!/usr/bin/env bash
set -euo pipefail

FLUTTER_SDK_DIR="${FLUTTER_SDK_DIR:-.vercel_flutter}"

if command -v flutter >/dev/null 2>&1; then
  FLUTTER_COMMAND="$(command -v flutter)"
elif [[ -x "flutter/bin/flutter" ]]; then
  FLUTTER_COMMAND="flutter/bin/flutter"
else
  if [[ ! -x "$FLUTTER_SDK_DIR/bin/flutter" ]]; then
    echo "Installing the Flutter stable SDK for this build..."
    git clone --depth 1 --branch stable https://github.com/flutter/flutter.git "$FLUTTER_SDK_DIR"
  fi
  FLUTTER_COMMAND="$FLUTTER_SDK_DIR/bin/flutter"
fi

mkdir -p assets/env
ENV_FILE_CONTENT="${ENVIRONMENT_KEY:-${ENVIROMENT_KEY:-}}"
if [[ -z "$ENV_FILE_CONTENT" ]]; then
  echo "Warning: ENVIRONMENT_KEY is not set; using an empty environment file."
fi
printf '%s' "$ENV_FILE_CONTENT" > assets/env/keys.env

"$FLUTTER_COMMAND" --version
"$FLUTTER_COMMAND" config --enable-web
"$FLUTTER_COMMAND" pub get
"$FLUTTER_COMMAND" build web --release
