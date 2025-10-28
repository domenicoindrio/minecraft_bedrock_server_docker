#!/bin/sh
set -e

BACKUP_DIR="/backup"
WORLD_DIR="/bedrock/worlds"

if [ -z "$1" ]; then
  echo "[!] No backup specified, using latest."
  BACKUP_FILE=$(ls -1t "$BACKUP_DIR"/*.tar.gz | head -1)
else
  BACKUP_FILE="$BACKUP_DIR/$1"
  if [ ! -f "$BACKUP_FILE" ]; then
    echo "[-] Backup file $BACKUP_FILE not found!"
    exit 1
  fi
fi

echo "[*] Restoring backup: $BACKUP_FILE"
rm -rf "$WORLD_DIR"/*
tar -xzf "$BACKUP_FILE" -C "$WORLD_DIR"

echo "[+] Restore complete."