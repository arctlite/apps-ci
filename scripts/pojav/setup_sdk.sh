#!/bin/bash
set -e

sudo apt-get update
sudo apt-get install -y wget unzip

ANDROID_SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip"
ANDROID_SDK_DIR="$HOME/android-sdk"

wget "$ANDROID_SDK_URL" -O android-commandline-tools.zip
mkdir -p "$ANDROID_SDK_DIR/cmdline-tools"
unzip android-commandline-tools.zip -d "$ANDROID_SDK_DIR/cmdline-tools"
mv "$ANDROID_SDK_DIR/cmdline-tools/cmdline-tools" "$ANDROID_SDK_DIR/cmdline-tools/latest"

export ANDROID_HOME=$ANDROID_SDK_DIR
export PATH="$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$PATH"

yes | sdkmanager --licenses
sdkmanager "platform-tools" "build-tools;34.0.0" "platforms;android-34"

