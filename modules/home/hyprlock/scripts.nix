{ username, ... }:
{
  home.file = {
    "/home/${username}/.local/bin/weather.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        # Get the current city using IP geolocation
        CITY=$(curl -s https://ipinfo.io/city 2>/dev/null)

        # Check if CITY is retrieved successfully
        if [[ -n "$CITY" ]]; then
            # Fetch weather info for the detected city from wttr.in
            weather_info=$(curl -s "wttr.in/$CITY?format=%c+%C+%t" 2>/dev/null)

            # Check if the weather info is valid
            if [[ -n "$weather_info" ]]; then
                echo "$weather_info"
            else
                echo "Weather info unavailable for $CITY"
            fi
        else
            echo "Unable to determine your location"
        fi
      '';
    };
    "/home/${username}/.local/bin/hyprlock-battery.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        battery_percentage=$(cat /sys/class/power_supply/*/capacity)
        battery_status=$(cat /sys/class/power_supply/*/status)
        charging_icon="󱐋"

        # Check if the battery is charging
        if [ "$battery_status" = "Charging" ]; then
          battery_icon="$charging_icon"
        fi

        # Output the battery percentage and icon
        echo "$battery_percentage% $battery_icon"
      '';
    };
    "/home/${username}/.local/bin/hyprlock-art.sh" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        url=$(playerctl metadata mpris:artUrl)
        artist=$(playerctl metadata xesam:artist)
        album=$(playerctl metadata xesam:album)
        metadata=$(printf "$artist - $album")

        if [ "$url" == "No player found" ]; then
        	exit
        elif [ -f "/home/${username}/.cache/albumart/$metadata.png" ]; then
        	echo "/home/${username}/.cache/albumart/$metadata.png"
        else
        	mkdir -p "/home/${username}/.cache/albumart"
        	curl -s "$url" -o "/home/${username}/.cache/albumart/$metadata"
        	magick "/home/${username}/.cache/albumart/$metadata" "/home/${username}/.cache/albumart/$metadata.png"
        	rm "/home/${username}/.cache/albumart/$metadata"
        	echo "/home/${username}/.cache/albumart/$metadata.png"
        fi
      '';
    };
  };
}
