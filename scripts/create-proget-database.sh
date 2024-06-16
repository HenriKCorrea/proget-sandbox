#!/bin/bash

#create database
docker exec -it proget-sandbox-inedo-sql-1 /opt/mssql-tools/bin/sqlcmd \
  -S localhost -U SA -P '«YourStrong!Passw0rd»' \
  -Q 'CREATE DATABASE [ProGet] COLLATE SQL_Latin1_General_CP1_CI_AS'

# Check if the database was created successfully
DB_EXISTS=$(docker exec -it proget-sandbox-inedo-sql-1 /opt/mssql-tools/bin/sqlcmd \
  -S localhost -U SA -P '«YourStrong!Passw0rd»' \
  -Q 'SELECT name FROM sys.databases' | grep -w 'ProGet')

if [ -z "$DB_EXISTS" ]; then
  echo "Fail to detect created database"
  exit 1
else
  echo "Database created successfully!"
fi