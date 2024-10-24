#!/bin/bash
# Open psql inside the postgres container
# usage: ./path_to_this_script env
#         where env is: test or dev

if [ ! -f docker-compose-sitra.yml ]; then
    echo "docker-compose-sitra.yml not in working directory. Run this script in repository root directory."
    exit 1
fi

ENV_FILE="sitra-$1.env"

if [ ! -f $ENV_FILE ]; then
    echo "Usage: $0 <dev|test> ($ENV_FILE not found)"
    exit 1
fi

source $ENV_FILE

# Figure out the right container to run the command in
CONTAINER=$(docker compose -f docker-compose-sitra.yml --env-file $ENV_FILE ps | grep postgres | cut -f 1 -d  " ")

# Run command
docker exec -it -u postgres $CONTAINER psql $POSTGRES_DB
