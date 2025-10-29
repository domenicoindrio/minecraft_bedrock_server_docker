#!/bin/sh
set -e

SOURCE_DIR="/backups"                # minecraft_backups volume
DESTINATION_DIR="/bedrock/worlds"    # minecraft_worlds volume

if [ -z "$1" ]; then
  echo "[!] No backup specified, using latest."
  BACKUP_FILE=$(ls -1t "$SOURCE_DIR"/*.tar.gz | head -1)
else
  BACKUP_FILE="$SOURCE_DIR/$1"
  if [ ! -f "$BACKUP_FILE" ]; then
    echo "[-] Backup file $BACKUP_FILE not found!"
    exit 1
  fi
fi

echo "[*] Restoring backup: $BACKUP_FILE"
rm -rf "$DESTINATION_DIR"/*
tar -xzf "$BACKUP_FILE" -C "$DESTINATION_DIR"

echo "[+] Restore complete."