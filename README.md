Here’s how you can manage two separate installation scripts—one for the version **with the clicker** and another for the version **without the clicker**. Each script will be independent, and the user can download and run the one that suits their needs. Both will still handle updating, installing required packages, copying the necessary files, and rebooting the system.

### 1. **With Clicker Script: `install_with_clicker.sh`**

```bash
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
SOURCE_PY_FILE="$SCRIPT_DIR/RaspiDigiDisplayClicker.py"
STARTUP_FILE_CLICK="$SCRIPT_DIR/autostartClick.txt"

# Define the destination paths
DEST_DESKTOP="/home/pi/Desktop/RaspiDigiDisplayClicker.py"
DEST_STARTUP="/etc/xdg/lxsession/LXDE-pi/autostart"
URL_FILE="/home/pi/display_url.txt"

# Copy the Python file to the desktop
echo "Installing with clicker functionality."
echo "Copying RaspiDigiDisplayClicker.py to the Desktop..."
cp "$SOURCE_PY_FILE" "$DEST_DESKTOP"

# Check if the copy was successful
if [ $? -eq 0 ]; then
    echo "RaspiDigiDisplayClicker.py copied successfully to the Desktop."
else
    echo "Failed to copy RaspiDigiDisplayClicker.py to the Desktop."
    exit 1
fi

# Copy the startup file with the clicker to /etc/xdg/lxsession/LXDE-pi/autostart
echo "Copying autostartClick.txt to /etc/xdg/lxsession/LXDE-pi/autostart..."
sudo cp "$STARTUP_FILE_CLICK" "$DEST_STARTUP"

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
```

### 2. **Without Clicker Script: `install_without_clicker.sh`**

```bash
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
# RaspiDigiDisplay Installer

This project contains two installation scripts, allowing you to install `RaspiDigiDisplay` either with or without the clicker functionality on a Raspberry Pi.

## Features

- Updates and upgrades your Raspberry Pi's package list.
- Installs required packages:
  - `declutter`
  - Python 3
- **Two installation options:**
  - With clicker: Installs the `RaspiDigiDisplayClicker.py` file and sets it to run on startup.
  - Without clicker: Runs the presentation without the clicker functionality.
- Stores the presentation URL in a separate file for easy updates.
- Automatically reboots the Raspberry Pi upon completion of the setup.

## Files

- `RaspiDigiDisplayClicker.py`: The main Python script for the RaspiDigiDisplay (only installed with the clicker functionality).
- `autostartClick.txt`: A configuration file to start both the browser and the clicker script at boot.
- `autostartnoclick.txt`: A configuration file to start the browser without the clicker functionality.
- `install_with_clicker.sh`: The installer script for the version **with** clicker functionality.
- `install_without_clicker.sh`: The installer script for the version **without** clicker functionality.
- `display_url.txt`: A file that contains the URL to be displayed by the Chromium browser in kiosk mode.

## Installation Instructions

### With Clicker
1. Download `install_with_clicker.sh` to your Raspberry Pi.
2. Ensure that the script has execution permissions:
   ```bash
   chmod +x install_with_clicker.sh
   ```
3. Run the installer:
   ```bash
   ./install_with_clicker.sh
   ```
4. The system will automatically reboot upon successful installation.

### Without Clicker
1. Download `install_without_clicker.sh` to your Raspberry Pi.
2. Ensure that the script has execution permissions:
   ```bash
   chmod +x install_without_clicker.sh
   ```
3. Run the installer:
   ```bash
   ./install_without_clicker.sh
   ```
4. The system will automatically reboot upon successful installation.

## How to Change the Displayed URL

The URL that Chromium will display in kiosk mode is stored in a file located at `/home/pi/display_url.txt`. To change the URL that is displayed, follow these steps:

1. Open the `display_url.txt` file in a text editor:
   ```bash
   nano /home/pi/display_url.txt
   ```

2. Replace the existing URL with the new one.

3. Save the file and exit the editor (`Ctrl+X`, then `Y`, then `Enter`).

4. Reboot the system for the changes to take effect:
   ```bash
   sudo reboot
   ```

## Requirements

- Raspberry Pi running Raspbian or a similar Linux-based distribution.
- Sufficient permissions to copy files to `/etc/xdg/lxsession/LXDE-pi/`.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
