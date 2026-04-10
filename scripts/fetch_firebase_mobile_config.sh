#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   bash scripts/fetch_firebase_mobile_config.sh <project_id> <android_app_id> <ios_app_id>
#
# Example:
#   bash scripts/fetch_firebase_mobile_config.sh campus-reddit \
#     1:1234567890:android:abcdef123456 \
#     1:1234567890:ios:abcdef123456

if [[ $# -ne 3 ]]; then
  echo "Usage: bash scripts/fetch_firebase_mobile_config.sh <project_id> <android_app_id> <ios_app_id>" >&2
  exit 1
fi

if ! command -v firebase >/dev/null 2>&1; then
  echo "firebase CLI is required. Install it first: npm install -g firebase-tools" >&2
  exit 1
fi

project_id="$1"
android_app_id="$2"
ios_app_id="$3"
repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

rm -f "$repo_root/android/app/google-services.json"
rm -f "$repo_root/ios/Runner/GoogleService-Info.plist"

firebase apps:sdkconfig ANDROID "$android_app_id" \
  --project "$project_id" \
  --out "$repo_root/android/app/google-services.json"

firebase apps:sdkconfig IOS "$ios_app_id" \
  --project "$project_id" \
  --out "$repo_root/ios/Runner/GoogleService-Info.plist"

echo "Wrote local Firebase mobile config files:" >&2
echo "  - android/app/google-services.json" >&2
echo "  - ios/Runner/GoogleService-Info.plist" >&2