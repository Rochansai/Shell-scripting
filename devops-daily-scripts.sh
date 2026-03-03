#!/bin/bash
# This is the shebang.
# It tells the system to execute this script using the Bash shell.

############################################################
################### PROJECT 1: DISK MONITOR ################
############################################################

# Set the disk usage warning threshold percentage
THRESHOLD=80

# Get disk usage of root (/) filesystem
# df -h /      -> shows disk usage in human readable format
# awk 'NR==2 {print $5}' -> selects second line and prints 5th column (usage %)
# sed 's/%//'  -> removes the % symbol
USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

# Compare disk usage with threshold
# -gt means "greater than"
if [ "$USAGE" -gt "$THRESHOLD" ]; then
    # If disk usage is greater than threshold
    echo "WARNING: Disk usage is ${USAGE}% - Above Threshold!"
else
    # If disk usage is normal
    echo "Disk usage is normal: ${USAGE}%"
fi

# Print separator line
echo "------------------------------------------------------"



############################################################
################ PROJECT 2: SERVICE MONITOR ################
############################################################

# Define the service name to monitor
SERVICE="nginx"

# systemctl is-active --quiet
# Returns exit code 0 if running
# Returns non-zero if not running
if systemctl is-active --quiet $SERVICE; then
    # If service is running
    echo "$SERVICE service is running."
else
    # If service is not running
    echo "$SERVICE service is NOT running."
    echo "Attempting to restart..."

    # Start the service
    systemctl start $SERVICE
fi

# Print separator line
echo "------------------------------------------------------"



############################################################
################## PROJECT 3: BACKUP SCRIPT ################
############################################################

# Define source directory to backup
SOURCE="/home/user/data"

# Define destination directory for backup
DEST="/home/user/backup"

# Get current date in YYYY-MM-DD format
DATE=$(date +%F)

# Create backup directory if it does not exist
# -p prevents error if directory already exists
mkdir -p $DEST

# Create compressed tar backup
# -c -> create archive
# -z -> gzip compression
# -f -> filename
tar -czf $DEST/backup-$DATE.tar.gz $SOURCE

# $? stores exit status of last command
# 0 means success
# non-zero means failure
if [ $? -eq 0 ]; then
    echo "Backup completed successfully: backup-$DATE.tar.gz"
else
    echo "Backup failed!"
fi

# Print separator line
echo "------------------------------------------------------"



############################################################
################# PROJECT 4: LOG CLEANUP ###################
############################################################

# Define log directory
LOG_DIR="/var/log"

# Define number of days
DAYS=7

# find command explanation:
# -type f        -> find only files
# -mtime +7      -> files modified more than 7 days ago
# -exec rm -f {} \; -> delete each found file
find $LOG_DIR -type f -mtime +$DAYS -exec rm -f {} \;

# Check if deletion command executed successfully
if [ $? -eq 0 ]; then
    echo "Logs older than $DAYS days deleted successfully."
else
    echo "Error occurred while deleting logs."
fi

# Print separator line
echo "------------------------------------------------------"



############################################################
################# PROJECT 5: CPU MONITOR ###################
############################################################

# Get CPU usage
# top -bn1        -> batch mode, single iteration
# grep "Cpu(s)"   -> filter CPU line
# awk '{print $2}' -> get CPU usage value
# cut -d. -f1     -> remove decimal part
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}' | cut -d. -f1)

# Compare CPU usage with 70% threshold
if [ "$CPU_USAGE" -gt 70 ]; then
    echo "High CPU Usage Detected: ${CPU_USAGE}%"
else
    echo "CPU Usage is Normal: ${CPU_USAGE}%"
fi

# Final message after script execution
echo "----------------- SCRIPT EXECUTION COMPLETED -----------------"
