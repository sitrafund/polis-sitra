#! /bin/bash

# Usage: `./scripts/apply-patches.sh [polis] [df-participation]`

./scripts/apply-polis-patches.sh "${1:-polis}"
./scripts/apply-df-participation-patches.sh "${2:-df-participation}"
