#!/bin/bash

# OS Switcher Uninstaller
set -e

# Define variables
SCRIPT_NAME="os-switcher.py"
DESKTOP_FILE="os-switcher.desktop"
VENV_DIR="venv"
POLKIT_RULE="/etc/polkit-1/rules.d/49-grub-reboot.rules"

# Check for sudo/root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This uninstaller must be run as root. Please use sudo." >&2
  exit 1
fi

echo "Welcome to the OS Switcher Uninstaller!"

# Step 1: Remove the desktop entry
echo "Removing desktop entry..."
if [ -f "/usr/share/applications/$DESKTOP_FILE" ]; then
  rm -f "/usr/share/applications/$DESKTOP_FILE"
  echo "Removed /usr/share/applications/$DESKTOP_FILE."
elif [ -f "$HOME/.local/share/applications/$DESKTOP_FILE" ]; then
  rm -f "$HOME/.local/share/applications/$DESKTOP_FILE"
  echo "Removed $HOME/.local/share/applications/$DESKTOP_FILE."
else
  echo "Desktop entry not found. Skipping."
fi

# Step 2: Remove the Polkit rule
echo "Removing Polkit rule if it exists..."
if [ -f "$POLKIT_RULE" ]; then
  rm -f "$POLKIT_RULE"
  echo "Polkit rule $POLKIT_RULE removed."
else
  echo "No Polkit rule found. Skipping."
fi

# Step 3: Remove the virtual environment
if [ -d "$VENV_DIR" ]; then
  echo "Do you want to delete the virtual environment ($VENV_DIR)? [y/N]"
  read -r RESPONSE
  if [[ "$RESPONSE" =~ ^[Yy]$ ]]; then
    rm -rf "$VENV_DIR"
    echo "Virtual environment deleted."
  else
    echo "Skipping virtual environment deletion."
  fi
else
  echo "No virtual environment found. Skipping."
fi

# Step 4: Remove the script file
echo "Do you want to delete the script file ($SCRIPT_NAME)? [y/N]"
read -r RESPONSE
if [[ "$RESPONSE" =~ ^[Yy]$ ]]; then
  if [ -f "$SCRIPT_NAME" ]; then
    rm -f "$SCRIPT_NAME"
    echo "Deleted $SCRIPT_NAME."
  else
    echo "$SCRIPT_NAME not found. Skipping."
  fi
else
  echo "Skipping script deletion."
fi

# Step 5: Confirm cleanup
echo "Do you want to remove any additional files or dependencies? [y/N]"
read -r RESPONSE
if [[ "$RESPONSE" =~ ^[Yy]$ ]]; then
  echo "Please specify the files/directories to delete, or type 'cancel' to skip:"
  read -r TARGET
  if [[ "$TARGET" != "cancel" ]]; then
    rm -rf "$TARGET"
    echo "Deleted $TARGET."
  else
    echo "Skipped additional cleanup."
  fi
else
  echo "No additional cleanup performed."
fi

# Final message
echo "Uninstallation complete! Any remaining files must be manually removed if needed."
