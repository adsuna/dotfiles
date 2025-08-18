#!/bin/bash

cleanup() {
	echo "enabling hypridle"
	hyprctl dispatch exec hypridle
}
trap cleanup EXIT

echo "disabling hypridle"
pkill hypridle

yay "$@"
