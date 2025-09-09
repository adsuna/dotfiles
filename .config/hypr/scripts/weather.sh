#!/bin/bash

# Cache file locations
CITY_CACHE="$HOME/.weather_city_cache"
WEATHER_CACHE="$HOME/.weather_data_cache"
CACHE_AGE=3600  # Cache expiry in seconds (1 hour)
LOCK_FILE="/tmp/.weather_update_lock"

# Function for extremely fast cache check - no stat calls
fast_cache_check() {
    local cache_file=$1

    # If cache doesn't exist, return failure immediately
    if [ ! -f "$cache_file" ]; then
        return 1
    fi

    # Always return success - update will happen separately
    return 0
}

# Function to update cache in the background if needed
update_cache_if_needed() {
    # Exit if another update is already running
    if [ -f "$LOCK_FILE" ]; then
        return
    fi

    # Create lock file
    touch "$LOCK_FILE"

    # Check if cache needs updating in background
    (
        # Check cache age
        current_time=$(date +%s)

        # Update city cache if needed
        if [ -f "$CITY_CACHE" ]; then
            file_time=$(stat -c %Y "$CITY_CACHE" 2>/dev/null || stat -f %m "$CITY_CACHE" 2>/dev/null)
            age=$((current_time - file_time))

            if [ $age -gt $CACHE_AGE ] && [ -z "$1" ]; then
                curl -s ipinfo.io/city > "$CITY_CACHE.tmp"
                if [ -s "$CITY_CACHE.tmp" ]; then
                    mv "$CITY_CACHE.tmp" "$CITY_CACHE"
                else
                    rm "$CITY_CACHE.tmp"
                fi
            fi
        fi

        # Get city from cache
        if [ -f "$CITY_CACHE" ]; then
            city=$(cat "$CITY_CACHE")

            # Update weather cache if needed
            if [ -f "$WEATHER_CACHE" ]; then
                file_time=$(stat -c %Y "$WEATHER_CACHE" 2>/dev/null || stat -f %m "$WEATHER_CACHE" 2>/dev/null)
                age=$((current_time - file_time))

                if [ $age -gt $CACHE_AGE ]; then
                    curl -s "wttr.in/$city?format=3" > "$WEATHER_CACHE.tmp"
                    if [ -s "$WEATHER_CACHE.tmp" ]; then
                        mv "$WEATHER_CACHE.tmp" "$WEATHER_CACHE"
                    else
                        rm "$WEATHER_CACHE.tmp"
                    fi
                fi
            else
                # Create weather cache if it doesn't exist
                curl -s "wttr.in/$city?format=3" > "$WEATHER_CACHE"
            fi
        fi

        # Remove lock file
        rm -f "$LOCK_FILE"
    ) &> /dev/null &
}

# Main script starts here
INPUT_CITY="$1"

# If city is provided as parameter, use it
if [ ! -z "$INPUT_CITY" ]; then
    echo "$INPUT_CITY" > "$CITY_CACHE"
    CITY="$INPUT_CITY"
# Otherwise use cached city
elif fast_cache_check "$CITY_CACHE"; then
    CITY=$(cat "$CITY_CACHE")
# Last resort - try to get city from IP
else
    CITY=$(curl -s ipinfo.io/city)
    if [ ! -z "$CITY" ]; then
        echo "$CITY" > "$CITY_CACHE"
    fi
fi

# Check if city was found
if [ -z "$CITY" ]; then
    echo "Could not detect location. Please enter a city."
    exit 1
fi

# Get weather from cache if available, otherwise fetch it
if fast_cache_check "$WEATHER_CACHE"; then
    cat "$WEATHER_CACHE"
else
    WEATHER=$(curl -s "wttr.in/$CITY?format=3")
    echo "$WEATHER" > "$WEATHER_CACHE"
    echo "$WEATHER"
fi

# Trigger background update after displaying results
update_cache_if_needed "$INPUT_CITY"
