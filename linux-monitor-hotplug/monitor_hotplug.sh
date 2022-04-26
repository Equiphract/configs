#!/bin/sh

# Get out of town if something errors
set -e

HDMI_STATUS=$(</sys/class/drm/card0/card0-HDMI-A-1/status )
DP_STATUS=$(</sys/class/drm/card0/card0-DP-1/status )

# The following is needed, otherwise xrandr executions have no effect... don't
# ask me why, all I know is that this wasted 3 hours of my life. I hate
# computers.
xrandr -v >> /dev/null

if [ "connected" == "$HDMI_STATUS" ]; then
	/usr/bin/xrandr --output HDMI-1 --same-as eDP-1 --auto --mode 1920x1080
elif [ "disconnected" == "$HDMI_STATUS" ]; then
	/usr/bin/xrandr --output HDMI-1 --off
fi

if [ "connected" == "$DP_STATUS" ]; then
  echo "connected detected" >> /tmp/hotplug_debug.log
	/usr/bin/xrandr --output DP-1 --left-of eDP-1 --auto
elif [ "disconnected" == "$DP_STATUS" ]; then
  echo "disconnected detected" >> /tmp/hotplug_debug.log
	/usr/bin/xrandr --output DP-1 --off
fi

