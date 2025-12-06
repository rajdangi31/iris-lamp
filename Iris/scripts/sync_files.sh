#!/usr/bin/env bash
set -e

# Lock so two syncs don't overlap
LOCKFILE="/tmp/iris_files_sync.lock"
exec 9>"$LOCKFILE"
if ! flock -n 9; then
  echo "[!] File sync already running, exiting."
  exit 0
fi

PRIMARY_WEBROOT="/srv/http/"
BACKUP_USER="iris"
BACKUP_HOST="100.83.235.87"     # <-- replace with VM's Tailscale IP
BACKUP_WEBROOT="/var/www/html/"

echo "[$(date)] [*] Starting file sync..."

# Sync everything EXCEPT identity and health endpoints
/usr/bin/rsync -avz --delete \
    --exclude 'identity.php' \
    --exclude 'health.php' \
    "$PRIMARY_WEBROOT" \
    "${BACKUP_USER}@${BACKUP_HOST}:${BACKUP_WEBROOT}"

echo "[$(date)] [+] File sync complete."
