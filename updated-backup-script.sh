#!/bin/bash
# Portable DevOps Daily Monitoring Script
# Works in restricted environments

############################################################
################### PROJECT 1: DISK MONITOR ################
############################################################

THRESHOLD=80

# Check if df command exists
if command -v df >/dev/null 2>&1; then
    USAGE=$(df . | awk 'NR==2 {print $5}' | sed 's/%//')

    if [ "$USAGE" -gt "$THRESHOLD" ]; then
        echo "WARNING: Disk usage is ${USAGE}% - Above Threshold!"
    else
        echo "Disk usage is normal: ${USAGE}%"
    fi
else
    echo "df command not available."
fi

echo "------------------------------------------------------"



############################################################
################ PROJECT 2: SERVICE MONITOR ################
############################################################

SERVICE="nginx"

# Check if systemctl exists
if command -v systemctl >/dev/null 2>&1; then
    if systemctl is-active --quiet $SERVICE; then
        echo "$SERVICE service is running."
    else
        echo "$SERVICE service is NOT running."
        echo "Attempting to restart..."
        systemctl start $SERVICE
    fi
else
    echo "systemctl not available in this environment."
fi

echo "------------------------------------------------------"



############################################################
################## PROJECT 3: BACKUP SCRIPT ################
############################################################

# Use current directory instead of /home
SOURCE="."
DEST="./backup"

DATE=$(date +%F)

mkdir -p "$DEST"

tar -czf "$DEST/backup-$DATE.tar.gz" "$SOURCE" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Backup completed successfully: backup-$DATE.tar.gz"
else
    echo "Backup failed! (Check permissions or source path)"
fi

echo "------------------------------------------------------"



############################################################
################# PROJECT 4: LOG CLEANUP ###################
############################################################

# Use current directory for safe testing
LOG_DIR="."
DAYS=7

if command -v find >/dev/null 2>&1; then
    find "$LOG_DIR" -type f -mtime +$DAYS -print >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "Log cleanup simulation completed (safe mode)."
    else
        echo "Error during cleanup."
    fi
else
    echo "find command not available."
fi

echo "------------------------------------------------------"



############################################################
################# PROJECT 5: CPU MONITOR ###################
############################################################

if command -v top >/dev/null 2>&1; then
    CPU_USAGE=$(top -bn1 2>/dev/null | grep "Cpu" | awk '{print $2}' | cut -d. -f1)

    # If CPU usage is empty, set default
    if [ -z "$CPU_USAGE" ]; then
        CPU_USAGE=0
    fi

    if [ "$CPU_USAGE" -gt 70 ]; then
        echo "High CPU Usage Detected: ${CPU_USAGE}%"
    else
        echo "CPU Usage is Normal: ${CPU_USAGE}%"
    fi
else
    echo "top command not available."
fi

echo "----------------- SCRIPT EXECUTION COMPLETED -----------------"
