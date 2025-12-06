#!/usr/bin/env bash
set -e

# Lock so DB syncs don't overlap
LOCKFILE="/tmp/iris_db_sync.lock"
exec 9>"$LOCKFILE"
if ! flock -n 9; then
  echo "[!] DB sync already running, exiting."
  exit 0
fi

DB_NAME="iris_db"
DB_USER="iris_user"
DB_PASS="irisqtrew132"     # <-- replace with your real DB password

BACKUP_USER="iris"
BACKUP_HOST="100.83.235.87"      # <-- same Tailscale IP as above

DUMP_FILE="/tmp/${DB_NAME}_dump_$(date +%F_%H%M%S).sql"

echo "[$(date)] [*] Dumping DB on PRIMARY..."
/usr/bin/mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$DUMP_FILE"

echo "[$(date)] [*] Copying dump to BACKUP..."
/usr/bin/scp "$DUMP_FILE" "${BACKUP_USER}@${BACKUP_HOST}:/tmp/${DB_NAME}_restore.sql"

echo "[$(date)] [*] Restoring DB on BACKUP..."
/usr/bin/ssh "${BACKUP_USER}@${BACKUP_HOST}" "/usr/bin/mysql -u $DB_USER -p'$DB_PASS' $DB_NAME < /tmp/${DB_NAME}_restore.sql"

echo "[$(date)] [*] Cleaning up local dump..."
rm -f "$DUMP_FILE"

echo "[$(date)] [+] DB sync complete."
