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
android_out="$repo_root/android/app/google-services.json"
ios_out="$repo_root/ios/Runner/GoogleService-Info.plist"
android_tmp="$(mktemp "$repo_root/android/app/google-services.json.tmp.XXXXXX")"
ios_tmp="$(mktemp "$repo_root/ios/Runner/GoogleService-Info.plist.tmp.XXXXXX")"

cleanup() {
  rm -f "$android_tmp" "$ios_tmp"
}

trap cleanup EXIT

firebase apps:sdkconfig ANDROID "$android_app_id" \
  --project "$project_id" \
  --out "$android_tmp"

firebase apps:sdkconfig IOS "$ios_app_id" \
  --project "$project_id" \
  --out "$ios_tmp"

mv "$android_tmp" "$android_out"
mv "$ios_tmp" "$ios_out"

trap - EXIT

echo "Wrote local Firebase mobile config files:" >&2
echo "  - android/app/google-services.json" >&2
echo "  - ios/Runner/GoogleService-Info.plist" >&2