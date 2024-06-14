#!/bin/bash
echo "Starting MySQL backup process..."

source .env


# Backup timestamp
TIMESTAMP=$(date +%Y%m%d%H%M%S)

# Use the correct command with variables
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe" -u"$MYSQL_DEV_ADMIN_DB_USERNAME" -p"$MYSQL_DEV_ADMIN_DB_PASSWORD" "$MYSQL_PROD_DB_NAME" > ./backups/mysql_backup_$TIMESTAMP.sql 2> ./backups/mysql_backup_$TIMESTAMP.error.log

# Print error log if it exists
if [ -s ./backups/mysql_backup_$TIMESTAMP.error.log ]; then
    echo "Errors found:"
    cat ./backups/mysql_backup_$TIMESTAMP.error.log
fi

echo "MySQL backup process completed successfully."


#"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump.exe"
