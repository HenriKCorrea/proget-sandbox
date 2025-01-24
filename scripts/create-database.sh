#!/bin/bash

# Save the current working directory and change to the script directory
pushd "$(dirname "$0")"

# Import environment variables from .env file to shell context
source ../.env

# Array of database names
databases=()
databases+=("ProGet")
# databases+=("BuildMaster")
# databases+=("Otter")

for db in "${databases[@]}"; do
  # Check if database exists
  DB_EXISTS=$(docker exec inedo-sql /opt/mssql-tools18/bin/sqlcmd \
    -C -S localhost -U SA -P ${MSSQL_SA_PASSWORD} \
    -Q 'SELECT name FROM sys.databases' | grep -w "$db")

  if [ -z "$DB_EXISTS" ]; then
    echo "Creating $db database..."
    docker exec inedo-sql /opt/mssql-tools18/bin/sqlcmd \
      -C -S localhost -U SA -P ${MSSQL_SA_PASSWORD} \
      -Q "CREATE DATABASE [$db] COLLATE SQL_Latin1_General_CP1_CI_AS"
  else
    echo "$db database already exists!"
  fi
done

# Revert back to the original working directory
popd