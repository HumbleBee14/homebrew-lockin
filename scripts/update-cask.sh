#!/usr/bin/env bash
# Updates Casks/lockin.rb to a given version by downloading that release's
# LockIn.dmg from GitHub and computing its SHA-256. Run from the tap repo root.
#
#   ./scripts/update-cask.sh 1.0.0
#
set -euo pipefail

VERSION="${1:?usage: update-cask.sh <version>  (e.g. 1.0.0, no leading v)}"
REPO="HumbleBee14/LockIn"
DMG_URL="https://github.com/${REPO}/releases/download/v${VERSION}/LockIn.dmg"
CASK="Casks/lockin.rb"

echo "Downloading ${DMG_URL}"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
curl -fL --retry 3 -o "$TMP/LockIn.dmg" "$DMG_URL"

SHA="$(shasum -a 256 "$TMP/LockIn.dmg" | awk '{print $1}')"
echo "version = ${VERSION}"
echo "sha256  = ${SHA}"

# Replace the first version "..." and sha256 "..." lines in the cask.
/usr/bin/sed -i '' \
  -e "s/^  version \".*\"/  version \"${VERSION}\"/" \
  -e "s/^  sha256 \".*\"/  sha256 \"${SHA}\"/" \
  "$CASK"

echo "Updated ${CASK}. Review the diff, then commit & push."
