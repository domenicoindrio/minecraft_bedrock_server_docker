#!/bin/sh
set -e

SOURCE_DIR="/bedrock/worlds"     # minecraft_worlds volume
DESTINATION_DIR="/backups"       # minecraft_backups volume

TIMESTAMP=$(date +%F_%H-%M-%S)
BACKUP_FILE="$DESTINATION_DIR/worlds_$TIMESTAMP.tar.gz"

echo "[*] Backing up Minecraft worlds from $SOURCE_DIR to $BACKUP_FILE..."
mkdir -p "$DESTINATION_DIR"
tar czf "$BACKUP_FILE" -C "$SOURCE_DIR" .
echo "[+] Backup complete."