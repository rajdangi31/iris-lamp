# Cron Synchronization Schedule

## File Synchronization
Runs every 5 minutes
*/5 * * * * /home/rach/Documents/Iris/scripts/sync_files.sh >> /home/rach/Documents/Iris/logs/sync_files.log 2>&1


## Database Synchronization
Runs every 10 minutes
*/10 * * * * /home/rach/Documents/Iris/scripts/sync_db.sh >> /home/rach/Documents/Iris/logs/sync_db.log 2>&1
