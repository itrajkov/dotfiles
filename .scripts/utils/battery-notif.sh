#!/bin/bash
while true
do
  charging=`acpi | grep Charging`
  battery_level=`acpi -b | grep -P -o '[0-9]+(?=%)'`
    if [ $battery_level -le 20 ] && [ "$charging" == "" ]; then
      notify-send --urgency=CRITICAL "Battery Low" "Level: ${battery_level}%"
      paplay /usr/share/sounds/freedesktop/stereo/suspend-error.oga
  fi
  sleep 300
done
