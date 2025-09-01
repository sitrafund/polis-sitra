#!/bin/bash
#
# Fetch (or update) the Computational Democracy Polis and Digifinland Client Participation repositories
#
# Usage: `./scripts/fetch-submodule-repositories.sh`
set -o errexit

./scripts/fetch-polis.sh
./scripts/fetch-df-participation.sh
