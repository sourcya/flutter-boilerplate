#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/_vercel_flutter.sh"

mkdir -p assets/env
ENV_FILE_CONTENT="${ENVIRONMENT_KEY:-${ENVIROMENT_KEY:-}}"
if [[ -z "$ENV_FILE_CONTENT" ]]; then
  echo "Warning: ENVIRONMENT_KEY is not set; using an empty environment file."
fi
printf '%s' "$ENV_FILE_CONTENT" > assets/env/keys.env

"$FLUTTER_COMMAND" build web --release

# Serve the docsify documentation site from the same deployment, under /docs,
# alongside the Flutter web app at /. See docs/web-deployment.md.
echo "Copying docs/ into build/web/docs ..."
rm -rf build/web/docs
cp -R docs build/web/docs
