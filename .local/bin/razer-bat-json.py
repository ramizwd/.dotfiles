#!/usr/bin/env python3
import json
from openrazer.client import DeviceManager

def get_battery():
    LVL_IDLE = 0
    LVL_LOW = 20
    LVL_HIGH = 80

    dm = DeviceManager()

    if not dm.devices:
        out = {
            "text": "No mouse",
            "tooltip": "No devices found. Ensure the daemon is running.",
            "class": "disc"
        }
        return json.dumps(out)

    for device in dm.devices:
        level = device.battery_level
        is_charging = device.is_charging
        state_class = ''

        icon = "󰍾" if level == LVL_IDLE else "󰍽"
        icon_charging = " " if is_charging else ""

        if level == LVL_IDLE:
            state_class = "disc"
        if level <= LVL_LOW and level != LVL_IDLE:
            state_class = "low"
        if is_charging:
            state_class = "charging"
        if is_charging and level >= LVL_HIGH:
            state_class = "high"

        out = {
            "text": f"{level}% {icon}{icon_charging}",
            "tooltip": f"{device.name}",
            "class": state_class
        }
        return json.dumps(out)
        break

if __name__ == "__main__":
    print(get_battery())
