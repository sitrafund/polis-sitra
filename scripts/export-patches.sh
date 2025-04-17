#!/bin/bash
#
# This script exports the git commits from our forked branch as patch files
# for storage in this repository.
# Run apply-patches.sh to re-apply the patches.
#
# Usage: `./scripts/export-patches.sh [polis] [df-participation]`

./scripts/export-polis-patches.sh "${1:-polis}"
./scripts/export-df-participation-patches.sh "${2:-df-participation}"
