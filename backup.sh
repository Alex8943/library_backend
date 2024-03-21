#!/bin/bash
echo "Starting MySQL backup process..."

source .env

# Backup timestamp
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Backup MySQL database to the project directory
#The script does not work et admin rights to the DB!! 
mysqldump -u "$MYSQL_DEV_ADMIN_DB_USERNAME" -p"$MYSQL_DEV_ADMIN_DB_PASSWORD" "$MYSQL_DEV_DB_NAME" > ./backups/mysql-backup-$TIMESTAMP.sql

echo "MySQL backup completed!"