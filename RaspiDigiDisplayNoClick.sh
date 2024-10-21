#!/bin/bash

# Update and Upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install decluttr
echo "Installing decluttr..."
sudo apt install declutter -y

# Install Python 3
echo "Installing Python 3..."
sudo apt install python3 -y

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define source files assuming they are in the same directory as the script
STARTUP_FILE_NOCLICK="$SCRIPT_DIR/autostartnoclick.txt"

# Define the destination paths
DEST_STARTUP="/etc/xdg/lxsession/LXDE-pi/autostart"
URL_FILE="/home/pi/display_url.txt"

# Copy the startup file without the clicker to /etc/xdg/lxsession/LXDE-pi/autostart
echo "Installing without clicker functionality."
echo "Copying autostartnoclick.txt to /etc/xdg/lxsession/LXDE-pi/autostart..."
sudo cp "$STARTUP_FILE_NOCLICK" "$DEST_STARTUP"

# Check if the startup copy was successful
if [ $? -eq 0 ]; then
    echo "Startup file copied successfully to /etc/xdg/lxsession/LXDE-pi/autostart."
else
    echo "Failed to copy startup file."
    exit 1
fi

# Create or update the URL file
echo "Creating or updating the URL file..."
echo "https://docs.google.com/presentation/d/e/2PACX-1vSXNiUZ2uTVt7ywnxMsvad9Mk03BnqMBSwLjhx1fskVajsx69FcrIHLkOPgixrQ-gNGfZkU-k9lZ93H/pub?start=false&loop=true&delayms=60000" > "$URL_FILE"

if [ $? -eq 0 ]; then
    echo "URL file created successfully."
else
    echo "Failed to create URL file."
    exit 1
fi

# Reboot the system
echo "Installation completed successfully. Rebooting now..."
sudo reboot
