#!/usr/bin/env bash
/**
 * IRIS Continuous Sync Helper
 * Uses inotifywait to trigger rsync on filesystem events.
 * Suggested in 'Future Enhancements' of the IRIS Research Paper.
 */

# Dependency Check
if ! command -v inotifywait &> /dev/null; then
    echo "[!] Error: inotify-tools is not installed."
    echo "Install it with: sudo pacman -S inotify-tools (Arch) or sudo apt install inotify-tools (Ubuntu)"
    exit 1
fi

# Load configuration from .env if it exists
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PARENT_DIR="$(dirname "$SCRIPT_DIR")"
if [ -f "$PARENT_DIR/.env" ]; then
    source "$PARENT_DIR/.env"
fi

WEBROOT="${WEBROOT:-/var/www/html/}"
SYNC_SCRIPT="$SCRIPT_DIR/sync_files.sh"

echo "[$(date)] [*] IRIS Watcher started on ${WEBROOT}"
echo "[*] Monitoring for changes... (Press Ctrl+C to stop)"

# Watch for create, modify, delete, and move events
inotifywait -m -r -e modify,create,delete,move "$WEBROOT" | while read path action file; do
    echo "[$(date)] Events detected ($action on $file). Triggering sync..."
    # Execute the existing sync script
    bash "$SYNC_SCRIPT"
done
