#!/bin/bash
# usage: ./path_to_this_script env
#         where env is: test or dev

if [ ! -f docker-compose-sitra.yml ]; then
    echo "docker-compose-sitra.yml not in working directory. Run this script in repository root directory."
    exit 1
fi

ENV_FILE="sitra-$1.env"

if [ ! -f $ENV_FILE ]; then
    echo "Usage: $0 <dev|test> [down] ($ENV_FILE not found)"
    exit 1
fi

if [ "$2" == "down" ]; then
    # Down removes, not just stops, the containers
    ACTION=down
elif [ "$2" == "" ] || [ "$2" == "stop" ]; then
    ACTION=stop
else
    echo "Usage $0 <dev|test| [down]"
    exit 1
fi

# stop containers
DOCKER_ENV=$1 docker compose -f docker-compose-sitra.yml -f docker-compose.dev.yml --env-file sitra-$1.env $ACTION
