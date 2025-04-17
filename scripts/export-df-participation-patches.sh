#!/bin/bash
#
# This script exports the git commits from our forked branch as patch files
# for storage in this repository.
# Run apply-patches.sh to re-apply the patches.
#
# Usage: `./scripts/export-df-participation-patches.sh [df-participation]`
set -o errexit

# Name of our branch we wish to export as patch files
FORK_BRANCH=sitra

# Directories
DF_REPO=$(realpath "${1:-df-participation}")
PATCH_DIR=$(realpath "df-participation-patches")

# The ID of the commit from which our patch formatted branch splits off
FORK_ROOT=$(<"$PATCH_DIR/fork")

# Clear out any old patches
cd "$PATCH_DIR"
rm -f *.patch

# Export patches
cd "$DF_REPO"
git format-patch $FORK_ROOT..$FORK_BRANCH -o "$PATCH_DIR"
