#!/usr/bin/env python3
import json
from openrazer.client import DeviceManager

def get_battery():
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

        icon = "󰍾" if level == 0 else "󰍽"
        charging_icon = " " if device.is_charging else ""

        classes = []
        if level == 0:
            classes.append("disc")
        if level <= 20 and level != 0:
            classes.append("low")
        if device.is_charging:
            classes.append("charging")
        if device.is_charging and level >= 80:
            classes.append("high")

        out = {
            "text": f"{level}% {icon}{ charging_icon}",
            "tooltip": f"{device.name}",
            "class": " ".join(classes)
        }
        return json.dumps(out)
        break

if __name__ == "__main__":
    print(get_battery())
