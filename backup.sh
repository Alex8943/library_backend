#!/bin/bash
echo "Starting MySQL backup process..."

source .env

# Backup timestamp
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Backup MySQL database to the project directory
#The script does not work et admin rights to the DB!! 
#MYSQL_PROD_DB_HOST=157.245.69.20
#MYSQL_PROD_DB_USERNAME=root
#MYSQL_PROD_DB_PASSWORD=McyQXtbYB6kXdRPh5nsK
#MYSQL_PROD_DB_NAME=kea_library
#MYSQL_PROD_DB_PORT=3306

mysqldump -u "$MYSQL_DEV_ADMIN_DB_USERNAME" -p"$MYSQL_DEV_ADMIN_DB_PASSWORD" "$MYSQL_PROD_DB_NAME" > ./backups/mysql-backup-$TIMESTAMP.sql

echo "MySQL backup completed this is a test!"