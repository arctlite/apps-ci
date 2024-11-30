#!/bin/bash
set -e

APK_ASSETS_DIR="app_pojavlauncher/src/main/assets/components"

# Clean up JRE directories
rm -rf "$APK_ASSETS_DIR/jre"
rm -rf "$APK_ASSETS_DIR/jre-new"
rm -rf "$APK_ASSETS_DIR/jre-21"

# Build APKs
gradle assembleRelease

