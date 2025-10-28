#!/bin/sh
set -e

BACKUP_DIR=/backup
WORLD_DIR=/bedrock/worlds
TIMESTAMP=$(date +%F_%H-%M-%S)
BACKUP_FILE="$BACKUP_DIR/worlds_$TIMESTAMP.tar.gz"

echo "[*] Backing up Minecraft worlds to $BACKUP_FILE..."
mkdir -p "$BACKUP_DIR"
tar czf "$BACKUP_FILE" -C "$WORLD_DIR" .
echo "[+] Backup complete."