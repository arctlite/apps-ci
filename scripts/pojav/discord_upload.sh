#!/bin/bash

APK_PATH="app_pojavlauncher/build/outputs/apk/release"
COMMIT_MESSAGE=$(git log -1 --pretty=format:"%s")
COMMIT_AUTHOR=$(git log -1 --pretty=format:"%an")
COMMIT_HASH=$(git log -1 --pretty=format:"%H")
BRANCHNAME=$(git rev-parse --abbrev-ref HEAD)
COMMIT_URL="https://github.com/PojavLauncher/commit/${COMMIT_HASH}"

curl -X POST \
     -H "Content-Type: multipart/form-data" \
     -F "payload_json={
       \"content\": \"\",
       \"embeds\": [
         {
           \"title\": \"Build Information\",
           \"description\": \"**Commit**: [${COMMIT_HASH}](${COMMIT_URL})\\n**Message**: ${COMMIT_MESSAGE}\\n**Author**: ${COMMIT_AUTHOR}\\n**Branch**: ${BRANCHNAME}\"
         }
       ]
     }" \
     "$DISCORD_WEBHOOK_URL"

curl -X POST \
     -H "Content-Type: multipart/form-data" \
     -F file=@"$APK_PATH/app_pojavlauncher-arm64-v8a-signed.apk" \
     -F "payload_json={\"content\":\"\"}" \
     "$DISCORD_WEBHOOK_URL"

