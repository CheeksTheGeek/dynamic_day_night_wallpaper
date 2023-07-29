-- BEGIN USER CONFIGURATION
global dayWallpaper, nightWallpaper, latitude, longitude, currentDirectory

-- Define the paths for day and night wallpapers
set currentFile to POSIX path of (path to me)
set currentDirectory to do shell script "dirname " & quoted form of currentFile
log "Current directory: " & currentDirectory -- Print the current directory for debugging
set dayWallpaper to currentDirectory & "/day.jpeg"
set nightWallpaper to currentDirectory & "/night.jpeg"

log "Day wallpaper: " & dayWallpaper -- Print the path of the day wallpaper for debugging
log "Night wallpaper: " & nightWallpaper -- Print the path of the night wallpaper for debugging

-- END USER CONFIGURATION

-- Get the current location
set locationData to do shell script "curl -s https://ipinfo.io/geo | jq -r '.loc'"
set {latitude, longitude} to text items of locationData
log "Current Latitude: " & latitude  & "Current Longitude: " & longitude

-- Helper function to get sunrise and sunset times
on getSunriseSunset()
	set apiURL to "https://api.sunrisesunset.io/json?lat=" & latitude & "&lng=" & longitude
	log apiURL -- Print the API URL for debugging
	set jsonResponse to do shell script "curl '" & apiURL & "'"
	log jsonResponse -- Print the JSON response for debugging
	set sunriseTime to do shell script "echo '" & jsonResponse & "' | jq -r '.results.sunrise'"
	set sunsetTime to do shell script "echo '" & jsonResponse & "' | jq -r '.results.sunset'"
	return {sunriseTime, sunsetTime}
end getSunriseSunset

-- Get current time
set currentTime to current date
log "Current time: " & currentTime -- Print the current time for debugging

-- Get sunrise and sunset times
set {sunriseTime, sunsetTime} to getSunriseSunset()
log "Sunrise time: " & sunriseTime -- Print the sunrise time for debugging
log "Sunset time: " & sunsetTime -- Print the sunset time for debugging
-- Convert sunrise and sunset times to date objects
set sunriseDate to date sunriseTime
set sunsetDate to date sunsetTime
log "Sunrise date: " & sunriseDate -- Print the sunrise date for debugging
log "Sunset date: " & sunsetDate -- Print the sunset date for debugging
-- Determine if it's day or night
set wallpaperPath to nightWallpaper
set dayOrNight to "night"
if currentTime is greater than sunriseDate and currentTime is less than sunsetDate then
	set wallpaperPath to dayWallpaper
	set dayOrNight to "day"
end if

log "It's " & dayOrNight & "." -- Print whether it's day or night for debugging
log "Setting wallpaper to: " & wallpaperPath -- Print the path of the wallpaper for debugging

-- Set the wallpaper
tell application "System Events"
	try
		set picture of current desktop to wallpaperPath
	end try
end tell
