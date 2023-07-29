# Dynamic Day Night Wallpaper

This is a simple AppleScript that changes your desktop wallpaper based on the time of day. It uses your current location to determine the sunrise and sunset times and switches between a day and night wallpaper accordingly.

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

To set up a cron job to run this script every 4 hours, follow these steps:

1. Open your crontab file with the command `crontab -e`.
2. Add a new line with the following format: `0 */4 * * * osascript /path/to/your/script`. Replace `/path/to/your/script` with the actual path to the AppleScript file.
3. Save and close the file by typing `:wq` and press Enter.

## Debugging

The script logs various information to the console for debugging purposes, such as the current directory, the paths of the wallpapers, the current location, the sunrise and sunset times, and the current time.

## Dependencies

This script requires `jq` to parse JSON responses from the Sunrise Sunset API. You can install it using Homebrew with the command `brew install jq`.