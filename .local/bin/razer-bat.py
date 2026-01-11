#!/usr/bin/env python3
import sys
from openrazer.client import DeviceManager

def get_battery():
    dm = DeviceManager()

    if not dm.devices:
        print("No devices found. Ensure the daemon is running.")
        return

    for device in dm.devices:
        charging_str = " - Charging..." if device.is_charging else ""
        print(f"{device.name}: {device.battery_level}%{charging_str}")

if __name__ == "__main__":
    try:
        get_battery()
    except Exception as e:
        print(f"Error: {e}")
        sys.exit(1)
