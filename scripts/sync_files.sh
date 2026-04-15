#!/usr/bin/env bash
/**
 * IRIS File Synchronization Script
 * Periodically syncs webroot from PRIMARY to BACKUP.
 */

set -e

# Load configuration from .env if it exists
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
if [ -f "$PARENT_DIR/.env" ]; then
    source "$PARENT_DIR/.env"
fi

# Fallback/Defaults with placeholders
PRIMARY_WEBROOT="${WEBROOT:-/var/www/html/}"
BACKUP_USER="${BACKUP_USER:-iris}"
BACKUP_HOST="${BACKUP_IP:-<BACKUP_NODE_IP>}"
BACKUP_WEBROOT="${WEBROOT:-/var/www/html/}"

# Lock so two syncs don't overlap
LOCKFILE="/tmp/iris_files_sync.lock"
exec 9>"$LOCKFILE"
if ! flock -n 9; then
    echo "[!] $(date) - File sync already running, exiting."
    exit 0
fi

echo "[$(date)] [*] Starting file sync to ${BACKUP_HOST}..."

# Sync everything EXCEPT node-specific identity files
# We keep identity.php unique to each node to verify routing
/usr/bin/rsync -avz --delete \
    --exclude 'identity.php' \
    --exclude 'health.php' \
    --exclude '.env' \
    --exclude '.git' \
    "$PRIMARY_WEBROOT" \
    "${BACKUP_USER}@${BACKUP_HOST}:${BACKUP_WEBROOT}"

echo "[$(date)] [+] File sync complete."
