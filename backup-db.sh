#!/bin/bash

REMOTE_NAME="cma-backup-db"
SERVER_NAME="CMA"
TODAY=$(date +"%F")
BACKUP_DIR="/mnt/sdb/database-backup"
BACKUP_TODAY_DIR="$BACKUP_DIR/$TODAY"
BACKUP_FILE="`date +%H:%M:%S`"
POSTGRES_CONTAINER_ID="cma-docker_cma-db_1"

# Begin
mkdir -p $BACKUP_TODAY_DIR

# Backup database
docker exec -t $POSTGRES_CONTAINER_ID pg_dumpall -c -U postgres > $BACKUP_TODAY_DIR/$BACKUP_FILE.dump

# Compression file
zip -q $BACKUP_TODAY_DIR/$BACKUP_FILE.zip $BACKUP_TODAY_DIR/$BACKUP_FILE.dump

# Upload to drive
rclone -q mkdir $REMOTE_NAME:$SERVER_NAME/$TODAY
rclone -q copy $BACKUP_TODAY_DIR/$BACKUP_FILE.zip $REMOTE_NAME:$SERVER_NAME/$TODAY

# Cleanup
rm -rf $BACKUP_TODAY_DIR/$BACKUP_FILE.zip
find $BACKUP_DIR/* -mtime +7 -exec rm -rf {} \;
rclone -q --min-age 7d delete "$REMOTE_NAME:$SERVER_NAME"
rclone -q --min-age 7d rmdirs "$REMOTE_NAME:$SERVER_NAME"
rclone cleanup "$REMOTE_NAME:"