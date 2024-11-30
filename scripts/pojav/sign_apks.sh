#!/bin/bash
set -e

APK_PATH="app_pojavlauncher/build/outputs/apk/release"
ANDROID_TOOLS_PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/build-tools/34.0.0"

export PATH="$ANDROID_TOOLS_PATH:$PATH"

# Align APKs
zipalign -v -p 4 "$APK_PATH/app_pojavlauncher-armeabi-v7a-release-unsigned.apk" "$APK_PATH/app_pojavlauncher-armeabi-v7a-aligned.apk"
zipalign -v -p 4 "$APK_PATH/app_pojavlauncher-arm64-v8a-release-unsigned.apk" "$APK_PATH/app_pojavlauncher-arm64-v8a-aligned.apk"

# Decode signing key
echo "$SIGNING_KEY" | base64 -d > signing_key.jks

# Sign APKs
apksigner sign --ks signing_key.jks --ks-key-alias "$KEY_ALIAS" \
               --ks-pass pass:"$SIGNING_KEY_PASSWORD" --key-pass pass:"$KEY_PASSWORD" \
               --out "$APK_PATH/app_pojavlauncher-armeabi-v7a-signed.apk" \
               "$APK_PATH/app_pojavlauncher-armeabi-v7a-aligned.apk"

apksigner sign --ks signing_key.jks --ks-key-alias "$KEY_ALIAS" \
               --ks-pass pass:"$SIGNING_KEY_PASSWORD" --key-pass pass:"$KEY_PASSWORD" \
               --out "$APK_PATH/app_pojavlauncher-arm64-v8a-signed.apk" \
               "$APK_PATH/app_pojavlauncher-arm64-v8a-aligned.apk"

# Verify signed APKs
apksigner verify "$APK_PATH/app_pojavlauncher-armeabi-v7a-signed.apk"
apksigner verify "$APK_PATH/app_pojavlauncher-arm64-v8a-signed.apk"

