#!/bin/bash

# Retrieve release ID from the previous step
RELEASE_ID=${{ steps.create-release.outputs.release_id }}

# Find APKs and upload them to the release
APK_FILES=$(find pojav/app_pojavlauncher/build/outputs/apk/release/ -name "*signed")

for APK in $APK_FILES; do
  curl -X POST \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Content-Type: application/octet-stream" \
    --data-binary @"$APK" \
    "https://uploads.github.com/repos/${GITHUB_REPOSITORY}/releases/$RELEASE_ID/assets?name=$(basename $APK)"
  echo "Uploaded APK: $(basename $APK)"
done

