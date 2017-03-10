#!/bin/bash
set -e

function init_user {

# gosu root adduser $DB_USERNAME --gecos "" --disabled-login

psql -v ON_ERROR_STOP=1 --username $POSTGRES_USER <<-EOSQL
  CREATE USER $DB_USERNAME WITH PASSWORD '$DB_PASSWORD';
  CREATE DATABASE $DB_DATABASE;
  GRANT ALL PRIVILEGES ON DATABASE $DB_DATABASE TO $DB_USERNAME;
EOSQL

}

id "$DB_USERNAME" >/dev/null 2>&1 || init_user
