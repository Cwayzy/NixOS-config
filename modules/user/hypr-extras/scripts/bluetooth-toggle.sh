#!/bin/bash
if bluetoothctl show | grep -q "Powered: yes"; then
    bluetoothctl power off
    notify-send "Bluetooth" "Disabled" -i bluetooth-disabled
else
    bluetoothctl power on
    notify-send "Bluetooth" "Enabled" -i bluetooth-active
fi
