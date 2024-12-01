#!/bin/bash

# Clone the PojavLauncher repository
echo "🌟 Cloning PojavLauncher Repository..."
git clone https://github.com/PojavLauncherTeam/PojavLauncher.git --depth 1 pojav
cd pojav || exit 1

echo "🔍 Extracting commit information..."
CURRENT_COMMIT_HASH=$(git rev-parse HEAD)
CURRENT_COMMIT_MSG=$(git log -1 --pretty=format:"%s")
CURRENT_COMMIT_AUTHOR=$(git log -1 --pretty=format:"%an")
CURRENT_COMMIT_DATE=$(git log -1 --pretty=format:"%cd" --date=short)

echo "Commit Details: 📝"
echo "  Hash: $CURRENT_COMMIT_HASH"
echo "  Message: $CURRENT_COMMIT_MSG"
echo "  Author: $CURRENT_COMMIT_AUTHOR"
echo "  Date: $CURRENT_COMMIT_DATE"

echo "📦 Saving commit details to the environment..."
echo "CURRENT_COMMIT_HASH=$CURRENT_COMMIT_HASH" >> $GITHUB_ENV
echo "CURRENT_COMMIT_MSG=$CURRENT_COMMIT_MSG" >> $GITHUB_ENV
echo "CURRENT_COMMIT_AUTHOR=$CURRENT_COMMIT_AUTHOR" >> $GITHUB_ENV
echo "CURRENT_COMMIT_DATE=$CURRENT_COMMIT_DATE" >> $GITHUB_ENV

cd ..
echo "✅ Repository cloned and commit information extracted successfully!"

