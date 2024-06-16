#!/bin/bash

# Save the current working directory and change to the script directory
pushd "$(dirname "$0")"

# Navigate to project root
cd ..

# Generate DB_PASSWORD
DB_PASSWORD=$(openssl rand -base64 32)
export DB_PASSWORD

# Create the .env file
echo "MSSQL_SA_PASSWORD=\"${DB_PASSWORD}\"" > .env
echo "PROGET_SQL_CONNECTION_STRING=\"Data Source=inedo-sql; Initial Catalog=ProGet; User ID=sa; Password=${DB_PASSWORD}\"" >> .env
echo "BUILDMASTER_SQL_CONNECTION_STRING=\"Data Source=inedo-sql; Initial Catalog=BuildMaster; User ID=sa; Password=${DB_PASSWORD}\"" >> .env
echo "OTTER_SQL_CONNECTION_STRING=\"Data Source=inedo-sql; Initial Catalog=Otter; User ID=sa; Password=${DB_PASSWORD}\"" >> .env

# Revert back to the original working directory
popd