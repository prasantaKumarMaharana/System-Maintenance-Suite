#!/bin/bash
# update_cleanup.sh - updates and cleans the Linux system
exec > >(tee -a "$HOME/MaintenanceSuite/run.log") 2>&1
echo "==============================================="
echo "🕒 Running $(basename "$0") on $(date '+%Y-%m-%d %H:%M:%S')"
echo "==============================================="
echo "🧹 Starting System Maintenance..."
echo "-------------------------------------"

# Show current disk usage
echo "💾 Disk usage before cleanup:"
df -h / | tail -1

# Run update and upgrade safely (with sudo if available)
if command -v sudo >/dev/null 2>&1; then
  echo "⬆ Updating system packages..."
  sudo apt update -y && sudo apt upgrade -y
else
  echo "⚠ Sudo not found, running without it..."
  apt update -y && apt upgrade -y
fi

# Clean up unnecessary packages
echo "🗑  Removing unused packages..."
sudo apt autoremove -y && sudo apt clean

# Show disk usage after cleanup
echo "💾 Disk usage after cleanup:"
df -h / | tail -1

# ✅ Add color-coded success message here
GREEN='\033[1;32m'
NC='\033[0m' # No Color
echo -e "${GREEN}✅ Maintenance complete!${NC}"

echo "-------------------------------------"
