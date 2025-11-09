#!/bin/bash
# log_monitor.sh - scans system logs for errors and alerts the user
exec > >(tee -a "$HOME/MaintenanceSuite/run.log") 2>&1
echo "==============================================="
echo "🕒 Running $(basename "$0") on $(date '+%Y-%m-%d %H:%M:%S')"
echo "==============================================="
LOG_FILE="/var/log/syslog"           # main system log file
ALERT_FILE="$HOME/MaintenanceSuite/log_alerts.txt"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

# Check if log file exists
if [ ! -f "$LOG_FILE" ]; then
  echo "❌ Error: Log file $LOG_FILE not found."
  exit 1
fi

# Create alert file if needed
touch "$ALERT_FILE"

# Scan for new errors or failures (case insensitive)
grep -iE "error|fail" "$LOG_FILE" > "$ALERT_FILE"

# Count number of alerts
COUNT=$(wc -l < "$ALERT_FILE")

# Color setup
RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m'

echo "-----------------------------------------"
echo "🧠 Log Monitor Report - $DATE"
echo "-----------------------------------------"

if [ "$COUNT" -gt 0 ]; then
  echo -e "${RED}⚠  $COUNT potential issues found!${NC}"
  echo "Check details in: $ALERT_FILE"
else
  echo -e "${GREEN}✅ No critical issues found.${NC}"
fi
