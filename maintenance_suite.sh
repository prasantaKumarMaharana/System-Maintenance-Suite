#!/bin/bash
# maintenance_suite.sh - Main Menu for System Maintenance
exec > >(tee -a "$HOME/MaintenanceSuite/run.log") 2>&1
# Color codes

# Color codes
CYAN='\033[1;36m'
GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

while true; do
  clear
  echo -e "${CYAN}============================================${NC}"
  echo -e "        🧰  SYSTEM MAINTENANCE SUITE"
  echo -e "${CYAN}============================================${NC}"
  echo "🕒 $(date '+%A, %d %B %Y  %H:%M:%S')"
  echo "--------------------------------------------"
  echo "1. 🗂  Backup Files"
  echo "2. 🧹 Update & Cleanup System"
  echo "3. 🧠 Monitor Logs for Errors"
  echo "4. 🚪 Exit"
  echo "5. 📊 Disk Usage Report"
  echo "--------------------------------------------"

  read -p "Enter your choice (1–5): " choice
  echo "--------------------------------------------"

  case $choice in
    1)
      echo -e "${GREEN}Running Backup Script...${NC}"
      ./backup.sh
      echo -e "${YELLOW}Press Enter to return to the menu...${NC}"
      read
      ;;
    2)
      echo -e "${GREEN}Running System Update & Cleanup...${NC}"
      ./update_cleanup.sh
      echo -e "${YELLOW}Press Enter to return to the menu...${NC}"
      read
      ;;
    3)
      echo -e "${GREEN}Running Log Monitor...${NC}"
      ./log_monitor.sh
      echo -e "${YELLOW}Press Enter to return to the menu...${NC}"
      read
      ;;
    4)
      echo -e "${RED}Exiting... Goodbye!${NC}"
      echo -e "\a"   # Terminal beep (fun)
      exit 0
      ;;
    5)
      echo -e "${GREEN}📊 Disk Usage Report:${NC}"
      df -h | grep -E "^Filesystem|/dev/"
      echo -e "\a"   # Beep after displaying
      echo -e "${YELLOW}Press Enter to return to the menu...${NC}"
      read
      ;;
    *)
      echo -e "${RED}Invalid choice! Please enter 1–5.${NC}"
      echo -e "\a"
      sleep 1
      ;;
  esac
done
