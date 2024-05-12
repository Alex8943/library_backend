#!/bin/bash
echo "Starting MySQL backup process..."

source .env

# Backup timestamp
TIMESTAMP=$(date +%Y%m%d%H%M%S)


mysqldump -u "$MYSQL_DEV_ADMIN_DB_USERNAME" -p"$MYSQL_DEV_ADMIN_DB_PASSWORD" "$MYSQL_PROD_DB_NAME" > ./backups/mysql_backup_$TIMESTAMP.sql

echo "MySQL backup process completed successfully."
