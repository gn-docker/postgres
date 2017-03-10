#!/bin/bash
set -e

function init_user {

# gosu root adduser $DB_USER --gecos "" --disabled-login

psql -v ON_ERROR_STOP=1 --username $POSTGRES_USER <<-EOSQL
  CREATE USER $DB_USER WITH PASSWORD '$DB_PASSWORD';
  CREATE DATABASE $DB_DATABASE;
  GRANT ALL PRIVILEGES ON DATABASE $DB_DATABASE TO $DB_USER;
EOSQL

}

id "$DB_USER" >/dev/null 2>&1 || init_user
