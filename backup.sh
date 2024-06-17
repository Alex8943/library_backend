#!/bin/bash

# Load environment variables from .env file
export $(grep -v '^#' .env | xargs)

# Backup timestamp
TIMESTAMP=$(date +%Y%m%d%H%M%S)


# Define the backup file path
BACKUP_FILE=./backups/mysql-backup-$TIMESTAMP.sql

# Run mysqldump using the environment variables and capture stderr
mysqldump -h $MYSQL_PROD_DB_HOST -P $MYSQL_PROD_DB_PORT -u $MYSQL_PROD_DB_USERNAME -p$MYSQL_PROD_DB_PASSWORD $MYSQL_PROD_DB_NAME > $BACKUP_FILE 2> ./backups/mysql-backup-$TIMESTAMP.log

# Check if mysqldump command was successful
if [ $? -eq 0 ]; then
    echo "Database backup completed and saved as $BACKUP_FILE"
else
    echo "Database backup failed. Check the log file for details: ./backups/mysql-backup-$TIMESTAMP.log"
fi
