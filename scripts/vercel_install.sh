#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/_vercel_flutter.sh"

"$FLUTTER_COMMAND" --version
"$FLUTTER_COMMAND" config --enable-web
"$FLUTTER_COMMAND" pub get
