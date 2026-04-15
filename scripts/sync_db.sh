#!/usr/bin/env bash
/**
 * IRIS Database Synchronization Script
 * Dumps MariaDB from PRIMARY and restores on BACKUP.
 */

set -e

# Load configuration from .env if it exists
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
if [ -f "$PARENT_DIR/.env" ]; then
    source "$PARENT_DIR/.env"
fi

# Fallback/Defaults with placeholders
DB_NAME="${DB_NAME:-iris_db}"
DB_USER="${DB_USER:-iris_user}"
DB_PASS="${DB_PASS:-<DB_PASSWORD>}"

BACKUP_USER="${BACKUP_USER:-iris}"
BACKUP_HOST="${BACKUP_IP:-<BACKUP_NODE_IP>}"

# Lock so DB syncs don't overlap
LOCKFILE="/tmp/iris_db_sync.lock"
exec 9>"$LOCKFILE"
if ! flock -n 9; then
    echo "[!] $(date) - DB sync already running, exiting."
    exit 0
fi

DUMP_FILE="/tmp/${DB_NAME}_sync_$(date +%F_%H%M%S).sql"

echo "[$(date)] [*] Dumping DB '${DB_NAME}' on PRIMARY..."
/usr/bin/mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$DUMP_FILE"

echo "[$(date)] [*] Transferring dump to BACKUP at ${BACKUP_HOST}..."
/usr/bin/scp "$DUMP_FILE" "${BACKUP_USER}@${BACKUP_HOST}:/tmp/iris_restore.sql"

echo "[$(date)] [*] Restoring DB on BACKUP..."
/usr/bin/ssh "${BACKUP_USER}@${BACKUP_HOST}" "/usr/bin/mysql -u $DB_USER -p'$DB_PASS' $DB_NAME < /tmp/iris_restore.sql && rm -f /tmp/iris_restore.sql"

echo "[$(date)] [*] Cleaning up local temporary file..."
rm -f "$DUMP_FILE"

echo "[$(date)] [+] DB sync complete."
