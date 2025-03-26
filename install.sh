#!/bin/bash

# OS Switcher Setup Script
set -e

# Define variables
SCRIPT_NAME="os-switcher.py"
DESKTOP_FILE="os-switcher.desktop"
REQUIREMENTS_FILE="requirements.txt"
VENV_DIR="venv"

# Ensure script is run with sudo/root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This setup script must be run as root. Please use sudo." >&2
  exit 1
fi

# Step 1: Create Python Virtual Environment
echo "Setting up Python virtual environment..."
if [ ! -d "$VENV_DIR" ]; then
  python3 -m venv "$VENV_DIR"
  echo "Virtual environment created at $VENV_DIR."
else
  echo "Virtual environment already exists. Skipping creation."
fi

# Step 2: Activate Virtual Environment and Install Dependencies
echo "Activating virtual environment and installing dependencies..."
source "$VENV_DIR/bin/activate"
if [ -f "$REQUIREMENTS_FILE" ]; then
  pip install -r "$REQUIREMENTS_FILE"
  echo "Dependencies installed."
else
  echo "Requirements file not found. Skipping dependency installation."
fi
deactivate

# Step 3: Create Desktop Entry
echo "Creating desktop entry..."
if [ ! -f "/usr/share/applications/$DESKTOP_FILE" ]; then
  cat <<EOF > "/usr/share/applications/$DESKTOP_FILE"
[Desktop Entry]
Name=OS Switcher
Exec=$PWD/$VENV_DIR/bin/python $PWD/$SCRIPT_NAME
Icon=system-reboot
Terminal=false
Type=Application
Categories=System;
EOF
  echo "Desktop entry created at /usr/share/applications/$DESKTOP_FILE."
else
  echo "Desktop entry already exists. Skipping creation."
fi

# Step 4: Make Script Executable
echo "Ensuring $SCRIPT_NAME is executable..."
chmod +x "$SCRIPT_NAME"
echo "$SCRIPT_NAME is now executable."

# Final Step: Success Message
echo "Setup completed successfully! You can now launch OS Switcher from the application menu."
