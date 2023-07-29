# Dynamic Day Night Wallpaper

This project is a simple AppleScript that changes your desktop wallpaper based on the time of day. It uses your current location to determine the sunrise and sunset times, and switches between a day and night wallpaper accordingly.

## How it Works

The script first determines the paths for the day and night wallpapers, which are expected to be in the same directory as the script itself and named `day.jpeg` and `night.jpeg`, respectively.

It then fetches the current location using the IP address of the machine where the script is running. This location data is used to get the sunrise and sunset times from the [Sunrise Sunset API](https://api.sunrise-sunset.org/).

The script then compares the current time with the sunrise and sunset times to determine whether it's day or night. Depending on this, it sets the desktop wallpaper to either the day or night wallpaper.

## Configuration

You can customize the day and night wallpapers by replacing the `day.jpeg` and `night.jpeg` files in the script's directory. The default wallpapers used in this project are from Wallpaper Flare:

- Day Wallpaper: [Fire 4K HD Full Screen](https://www.wallpaperflare.com/fire-4k-hd-full-screen-wallpaper-tealx/download)
- Night Wallpaper: [Firewatch 4K Best](https://www.wallpaperflare.com/firewatch-4k-best-wallpaper-temgv/download)

Please ensure to respect the copyright and licensing terms of any images you use.

## Usage

To use this script, simply run it on your machine. You can schedule it to run at regular intervals (for example, every hour) to keep your wallpaper in sync with the day-night cycle.

### Using the Bash Script

This project includes a bash script that sets up a launch agent to run the AppleScript every 4 hours. Here's how to use it:

1. Open Terminal.
2. Navigate to the directory containing the bash script.
3. Run the bash script with the command `./setup.sh`. Replace `setup.sh` with the actual name of the bash script.
4. The script will create a .plist file and move it to `~/Library/LaunchAgents`. It will then load the launch agent using `launchctl`.
5. The script will output a message indicating whether the job was loaded successfully.

To unload the job, run the bash script with the argument `rm`, like so: `./setup.sh rm`.

### Legacy Option: Using Cron

As a legacy option, you can also set up a cron job to run this script every 4 hours. Here's how:

1. Open Terminal.
2. Type `crontab -e` to open your crontab file.
3. Add a new line with the following format: `0 */4 * * * osascript /path/to/your/script`. Replace `/path/to/your/script` with the actual path to the AppleScript file.
4. Save and close the file by typing `:wq` and pressing Enter.

## Debugging

The script logs various information to the console for debugging purposes, such as the current directory, the paths of the wallpapers, the current location, the sunrise and sunset times, and the current time.

## Dependencies

This script requires `jq` to parse JSON responses from the Sunrise Sunset API. You can install it using Homebrew with the command `brew install jq`.