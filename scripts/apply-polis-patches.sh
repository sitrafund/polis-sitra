#!/bin/bash
#
# This script applies the patches from the patches folder to the polis repository.
# The export-patches.sh script performs the reverse operation.
#
# Usage: `./scripts/apply-patches.sh [polis]`
set -o errexit

# Name of our branch we wish to create
FORK_BRANCH=sitra

# Directories
POLIS_REPO=$(realpath "${1:-polis}")
PATCH_DIR=$(realpath patches)

# The ID of the commit from which our patch formatted branch splits off
FORK_ROOT=$(<"$PATCH_DIR/fork")

cd "$POLIS_REPO"

# First, check that the working copy is clean
if [ -n "$(git status --porcelain)" ]; then
    echo "Repository working copy is not clean. Clean it before applying patches."
    exit 1
fi

# Prompt before overwriting existing branch
if [ -n "$(git branch -l $FORK_BRANCH)" ]; then
    echo "Branch $FORK_BRANCH already exists."
    read -p "Replace? (type 'replace' to continue): " confirmation
    if [ "$confirmation" != "replace" ]; then
        echo "Patching cancelled."
        exit 1
    fi
    git checkout $FORK_BRANCH
else
    git checkout -b $FORK_BRANCH
fi

# Reset branch and apply patches
git reset --hard $FORK_ROOT
git am "$PATCH_DIR"/*.patch

# Fix math server entrypoint script line feeds (ensure math worker starting correctly when using git and building images on Windows/WSL)
dos2unix math/bin/run
