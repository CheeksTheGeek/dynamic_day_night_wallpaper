#!/bin/bash

# Get the current username
username=$(whoami)

# Set the label string
label="com.$username.DayAndNightWallpaper"

# Get the current directory
current_dir=$(pwd)

# Set the path to the AppleScript
script_path="$current_dir/DayNightWall.applescript"

# Check if the script exists
if [[ ! -f "$script_path" ]]; then
    echo "The script $script_path does not exist"
    exit 1
fi

# Create the plist content
plist_content="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<!DOCTYPE plist PUBLIC \"-//Apple//DTD PLIST 1.0//EN\" \"http://www.apple.com/DTDs/PropertyList-1.0.dtd\">
<plist version=\"1.0\">
<dict>
    <key>Label</key>
    <string>$label</string>
    <key>ProgramArguments</key>
    <array>
        <string>osascript</string>
        <string>$script_path</string>
    </array>
    <key>StartInterval</key>
    <integer>14400</integer>
    <key>RunAtLoad</key>
    <true/>
</dict>
</plist>"

# Print the plist content to a .plist file
echo "$plist_content" > "./$label.plist"

# Move the plist to ~/Library/LaunchAgents
mv "./$label.plist" "$HOME/Library/LaunchAgents/$label.plist"

# Change permission of the plist file to current user
chown $username "$HOME/Library/LaunchAgents/$label.plist"

# Load or unload the plist file into/from launchctl based on the argument passed
if [ "$1" == "rm" ]; then
    sudo launchctl bootout gui/$(id -u $username) "$HOME/Library/LaunchAgents/$label.plist"
else
    sudo launchctl bootstrap gui/$(id -u $username) "$HOME/Library/LaunchAgents/$label.plist"
fi

# Check if the plist is loaded
if launchctl list | grep -q $label; then
    echo "The job is loaded successfully"
else
    echo "The job is not loaded or was unloaded successfully"
fi
