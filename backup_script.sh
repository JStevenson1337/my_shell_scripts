#!/usr/bin/env bash
# Backup script

BACKUP_USER_HOME = "~/"
FORMATTED_DATE = $(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_DIR = "/media/backup/"
BACKUP_NAME = "backup_`$FORMATTED_DATE`.tar.gz"
BACKUP_PATH = "$BACKUP_DIR$BACKUP_NAME"
REMOTE_BACKUP_DIR = "nfs://10.10.120.10/backup/"
REMOTE_BACKUP_PATH = "$REMOTE_BACKUP_DIR$BACKUP_NAME"


# Make sure Drive is mounted
if [ ! -d "$BACKUP_DIR" ]; then
	echo "Drive not mounted"
	
fi

# Create backup
tar -czf $BACKUP_PATH $BACKUP_USER_HOME

FLAGS = "-rvz \
	--include=/etc --include=/etc/fstab \
    --include=/home \
	--checksum \
	--itemize-changes \
	--exclude= "./exclude.txt" \

define dry_run
	rsync $FLAGS --dry-run $1 $2
endef

LOG_FILE = "`$BACKUP_DIR`/backup_`$FOMATTED_DATE`/backup_`$FORMATTED_DATE`.log"

if 
# Backup to external drive
DESTINATION = "/media/backup/backup_`$FORMATTED_DATE`.tar.gz"

# Backup to local drive
# DESTINATION = "/home/user/backup_`$FORMATTED_DATE`.tar.gz"

