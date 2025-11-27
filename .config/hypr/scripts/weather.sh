#!/bin/bash

# Cache file locations
CITY_CACHE="$HOME/.weather_city_cache"
WEATHER_CACHE="$HOME/.weather_data_cache"
CACHE_AGE=3600
LOCK_FILE="/tmp/.weather_update_lock"

fast_cache_check() {
    local cache_file=$1
    [ -f "$cache_file" ]
}

update_cache_if_needed() {
    if [ -f "$LOCK_FILE" ]; then return; fi
    touch "$LOCK_FILE"

    (
        current_time=$(date +%s)

        # update city cache
        if [ -f "$CITY_CACHE" ]; then
            file_time=$(stat -c %Y "$CITY_CACHE" 2>/dev/null || stat -f %m "$CITY_CACHE" 2>/dev/null)
            if [ $((current_time - file_time)) -gt $CACHE_AGE ] && [ -z "$1" ]; then
                curl -s ipinfo.io/city > "$CITY_CACHE.tmp"
                [ -s "$CITY_CACHE.tmp" ] && mv "$CITY_CACHE.tmp" "$CITY_CACHE" || rm "$CITY_CACHE.tmp"
            fi
        fi

        # get city
        if [ -f "$CITY_CACHE" ]; then
            city=$(cat "$CITY_CACHE")

            # update weather
            if [ -f "$WEATHER_CACHE" ]; then
                file_time=$(stat -c %Y "$WEATHER_CACHE" 2>/dev/null || stat -f %m "$WEATHER_CACHE" 2>/dev/null)
                if [ $((current_time - file_time)) -gt $CACHE_AGE ]; then
                    curl -s "wttr.in/$city?format=3" > "$WEATHER_CACHE.tmp"
                    [ -s "$WEATHER_CACHE.tmp" ] && mv "$WEATHER_CACHE.tmp" "$WEATHER_CACHE" || rm "$WEATHER_CACHE.tmp"
                fi
            else
                curl -s "wttr.in/$city?format=3" > "$WEATHER_CACHE"
            fi
        fi

        rm -f "$LOCK_FILE"
    ) &> /dev/null &
}

INPUT_CITY="$1"

if [ -n "$INPUT_CITY" ]; then
    echo "$INPUT_CITY" > "$CITY_CACHE"
    CITY="$INPUT_CITY"
elif fast_cache_check "$CITY_CACHE"; then
    CITY=$(cat "$CITY_CACHE")
else
    CITY=$(curl -s ipinfo.io/city)
    [ -n "$CITY" ] && echo "$CITY" > "$CITY_CACHE"
fi

if [ -z "$CITY" ]; then
    echo "could not detect location" >&2
    exit 1
fi

# ---- print ONLY weather (strip city name + colon) ----
print_weather_only() {
    # wttr format: "City: 🌤 +24°C"
    # strip everything before first colon+space
    sed 's/^[^:]*: *//'
}

# get weather, strip city
if fast_cache_check "$WEATHER_CACHE"; then
    cat "$WEATHER_CACHE" | print_weather_only
else
    WEATHER=$(curl -s "wttr.in/$CITY?format=3")
    echo "$WEATHER" > "$WEATHER_CACHE"
    echo "$WEATHER" | print_weather_only
fi

update_cache_if_needed "$INPUT_CITY"
