#!/bin/bash

VERSION_TAG="build-${GITHUB_RUN_NUMBER}-${GITHUB_SHA}"
RELEASE_URL="https://api.github.com/repos/${GITHUB_REPOSITORY}/releases"

# Create a new GitHub Release
RESPONSE=$(curl -X POST $RELEASE_URL \
  -H "Authorization: token $GITHUB_TOKEN" \
  -d @- <<EOF
{
  "tag_name": "$VERSION_TAG",
  "target_commitish": "$GITHUB_SHA",
  "name": "Build $VERSION_TAG",
  "body": "Automated APK build for commit $GITHUB_SHA",
  "draft": false,
  "prerelease": false
}
EOF
)

# Extract the release ID from the response
RELEASE_ID=$(echo "$RESPONSE" | jq -r .id)
echo "Release created with ID: $RELEASE_ID"
echo "::set-output name=release_id::$RELEASE_ID"

