Polis Deployment for Sitra
--------------------------

Polis is an open-source online platform designed to enable a constructive exchange of opinions around a given topic. Sitra is introducing this democracy innovation in Finland in co-operation with DigiFinland.
More information about Polis can be found at https://pol.is/home and at Sitra's website https://www.sitra.fi/en/projects/polis-platform-experiments/.

This project contains set of deploy scripts, settings files, custom patches, translations and utilities for running Polis deployments for Sitra.

Project uses [Polis](https://github.com/compdemocracy/polis/) codebase with customizations and settings for Sitra.
Patches from [DigiFinland's Polis project](https://github.com/polis-digifinland/polis-digifinland/) are also included.
Project uses [Digifinland's participation frontend](https://github.com/polis-digifinland/df-participation) codebase with customizations for Sitra.


## Local dev env quickstart

1. Clone this repository

2. Run `./scripts/fetch-submodule-repositories.sh` to fetch or update the Polis source and DF participation source

3. Run `./scripts/apply-patches.sh` to apply Sitra and DigiFinland customizations to Polis and DF participation

4. Add `polis.local` entry to your local DNS or hosts file:

    ```
    127.0.0.1 	polis.local
    ```

5. Make a copy of sitra-example.env and modify to suit your local environment

6. Start the dev server using Docker Compose

    ```
    ./scripts/docker-compose_start.sh <env>
    ```
    
(where `<env>` is the name of your `sitra-<env>.env` environment)

7. Browse to https://polis.local

## Database setup

When using the Docker Compose managed dev enviroment, the database will be initialized automatically.

When using an external PostgreSQL server, you must initialize the database structure manually.

Step 1. Create the database:

```sql
CREATE USER polis WITH PASSWORD 'password';
CREATE DATABASE polis WITH owner=polis;
```

Step 2. Run database migrations:

```
cat polis/server/postgres/migrations/*.sql | psql -U polis polis
```

## Creating new patches

The apply-patches script applies the patches to a git branch, creating a new commit for each. The `export-patches.sh` script does the opposite: exports the commits in the branch into patch files.

Note: by convention, the commit message should start with either `DF:` or `Sitra:` to indicate the origin of the commit.

To **upgrade Polis**, do the following steps:

1. Apply patches to the current polis repo
2. Fetch changes from origin and choose the commit you wish to use as the new fork point
3. Rebase the sitra branch onto that commit, correcting any conflicts that may arise (development work: ideally the rebase goes through without conflicts, but depending on upstream changes, this may require rewriting the modifications.)
4. Test for regressions
5. Write the branch origin commit ID into the `patches/fork` file
6. Run `scripts/export-polis-patches.sh` to re-export the branch and commit the changed patches

To **upgrade DF-participation**, do the following steps:

1. Apply patches to the current df-participation repo
2. Fetch changes from origin and choose the commit you wish to use as the new fork point
3. Rebase the sitra branch onto that commit, correcting any conflicts that may arise (development work: ideally the rebase goes through without conflicts, but depending on upstream changes, this may require rewriting the modifications.)
4. Test for regressions
5. Write the branch origin commit ID into the `df-participation-patches/fork` file
6. Run `scripts/export-df-participation-patches.sh` to re-export the branch and commit the changed patches

## Docker Compose

The scripts directory contains a few helper scripts for Docker Compose. They take as argument the target environment name, which corresponds to a `sitra-<env>.env` file in the repository root.

 * `docker-compose_start.sh <env>` - start the application with the given env
 * `docker-compose_stop.sh <env> [down]` - stop the application. If `down` is passed, docker-compose down is run to also remove the containers.
 * `docker-compose_logs.sh <env>` - get docker logs
 * `docker-compose_psql.sh <env>` - run psql in the database container


## Minikube & Skaffold

**Heads up! DF-participation local kubernetes configuration are not implemented yet. Use docker compose for development**

Local Kubernetes configuration files are in `./manifests/local` directory.
See skaffold.yaml for artifacts and build config.

Starts local Minikube cluster with metrics and ingress addons, and starts ingress tunnel:
```
./scripts/k8s_start-local-minikube.sh
```

Builds and deploys containers using Skaffold:
```
skaffold run
```

Alternatively, to use image pruning, you can run:
```
skaffold dev --no-prune=false --cache-artifacts=false
```

## Licensing

[Polis](https://github.com/compdemocracy/polis/) is distributed under the [AGPL license](./LICENSE.md). All modifications used in the Sitra deployment are included in this repository.
Patches beginning with `DF:` originate from [DigiFinland](https://github.com/polis-digifinland/polis-digifinland/).


# Contact us
To get more information about this project, please write to us at polis@sitra.fi.
