# Shell-scripting
# DevOps Shell Scripts Project

This repository contains basic real-world shell scripts used by DevOps engineers in daily operations.

## Scripts Included

1. Disk Monitoring Script
   - Checks root disk usage
   - Alerts if usage crosses threshold

2. Service Monitoring Script
   - Checks if a service (nginx) is running
   - Restarts automatically if down

3. Backup Script
   - Creates compressed tar backup
   - Uses date-based naming

4. Log Cleanup Script
   - Deletes logs older than 7 days
   - Prevents disk space issues

## Concepts Used

- Variables
- If conditions
- Command substitution
- awk, sed
- find command
- tar command
- systemctl
- Exit codes
- Basic automation

## How to Run

Make scripts executable:

chmod +x scriptname.sh

Run:

./scriptname.sh

## Future Improvements

- Add email alerts
- Add cron scheduling
- Add logging to file
- Add error handling
