#!/bin/bash

set -o nounset
set -o errexit


#source /docker-entrypoint-initdb.d/scripts/00-setenv.sh
#source /docker-entrypoint-initdb.d/scripts/11-create-tablespace-folder.sh
#source /docker-entrypoint-initdb.d/scripts/21-create-database.sh
#source /docker-entrypoint-initdb.d/scripts/22-create-schema.sh

#cd /

echo ''
echo 'Running 00_initdb.sh'
echo 'Setting environment'
echo ''

export APP_DATABASE_NAME=$LONG_APP_NAME
export APP_USER_NAME=$LONG_APP_NAME
export APP_WWW_USER_NAME=www_$LONG_APP_NAME
export APP_TABLESPACES=$PGTABLESPACES
export LC_NAME=$LANG

echo 'APP_DATABASE_NAME='$APP_DATABASE_NAME
echo 'APP_USER_NAME='$APP_USER_NAME
echo 'APP_WWW_USER_NAME='$APP_WWW_USER_NAME
echo 'APP_TABLESPACES='$APP_TABLESPACES
echo ''

# ls -l /var/lib/postgresql/app


echo 'Creating dir '$APP_TABLESPACES
mkdir -p $APP_TABLESPACES
#chown -R postgres:postgres $APP_TABLESPACES
#chmod 777 $APP_TABLESPACES

set -e

echo ''
echo 'Creating database '$APP_DATABASE_NAME
echo ''

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    
    CREATE DATABASE $APP_DATABASE_NAME
        WITH OWNER = postgres
        ENCODING = 'UTF8'
        TABLESPACE = pg_default
        LC_COLLATE = '$LC_NAME'
        LC_CTYPE = '$LC_NAME'
        CONNECTION LIMIT = -1;

    ALTER DATABASE $APP_DATABASE_NAME SET client_encoding='UTF8';

    CREATE ROLE $APP_USER_NAME LOGIN
    ENCRYPTED PASSWORD '$APP_USER_NAME'
    NOSUPERUSER NOINHERIT NOCREATEDB NOCREATEROLE;

    CREATE ROLE $APP_WWW_USER_NAME LOGIN
    ENCRYPTED PASSWORD '$APP_WWW_USER_NAME'
    NOSUPERUSER NOINHERIT NOCREATEDB NOCREATEROLE;

    CREATE TABLESPACE $APP_DATABASE_NAME
    owner $APP_USER_NAME
    LOCATION '$APP_TABLESPACES';

    ALTER ROLE $APP_USER_NAME set default_tablespace=$APP_DATABASE_NAME;

    ALTER DATABASE $APP_DATABASE_NAME OWNER to $APP_USER_NAME;

EOSQL


psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$APP_DATABASE_NAME" <<-EOSQL
    
    CREATE SCHEMA $APP_DATABASE_NAME AUTHORIZATION $APP_USER_NAME;

    GRANT USAGE ON SCHEMA $APP_DATABASE_NAME to $APP_WWW_USER_NAME;
    
    ALTER ROLE $APP_WWW_USER_NAME SET search_path=$APP_DATABASE_NAME;

EOSQL






