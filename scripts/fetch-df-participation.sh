#!/bin/bash
#
# Clone (or update) the Digifinland Client Participation frontend repository
#
# Usage: `./scripts/fetch-df-participation.sh`
set -o errexit

cd "$(git rev-parse --show-toplevel)"

if [ -e df-participation/.git ]; then
    cd df-participation
    git fetch
else
    git clone https://github.com/polis-digifinland/df-participation.git
fi
