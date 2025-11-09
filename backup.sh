#!/bin/bash
# backup.sh - creates a compressed backup of a directory

exec > >(tee -a "$HOME/MaintenanceSuite/run.log") 2>&1
echo "==============================================="
echo "🕒 Running $(basename "$0") on $(date '+%Y-%m-%d %H:%M:%S')"
echo "==============================================="

SRC="/home/prasanta/Documents"        # <-- update this path if needed
DEST="/home/prasanta/Backups"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
FILE="$DEST/backup_$DATE.tar.gz"

# Create destination folder if not exists
mkdir -p "$DEST"

# Run backup
if tar -czf "$FILE" "$SRC" 2>/dev/null; then
  echo "✅ Backup created successfully at: $FILE"
else
  echo "⚠ Backup failed. Check if the source folder exists."
fi
