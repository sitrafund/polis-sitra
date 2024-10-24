#!/bin/bash
#
# Clone (or update) the Computational Democracy Polis repository
#
# Usage: `./scripts/clone-polis.sh`
set -o errexit

cd "$(git rev-parse --show-toplevel)"

if [ -e polis/.git ]; then
    cd polis
    git fetch
else
    git clone https://github.com/compdemocracy/polis.git
fi
