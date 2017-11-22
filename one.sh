#!/bin/bash

if [ -z $1 ]; then
	echo "Parameter does not exist"
	echo "Try one.sh -h"

elif [ $1 == "-s" ] || [ $1 == "--start" ]; then
	echo "Creating folder one in /var/run/one and /var/lock..."
	sudo mkdir /var/run/one
	sudo chown -R opennebula /var/run/one
	mkdir /var/lock/one
	echo "Folders created"
	echo "Starting one..."
	one start
	echo "one started"
	echo "Starting sunstone-server..."
	sunstone-server start

	# Adjust resolution
	xrandr --newmode "2560x1440_40.00"  201.00  2560 2720 2984 3408  1440 1443 1448 1476 +hsync +vsync
	xrandr --addmode HDMI-1 2560x1440_40.00
	xrandr --output HDMI-1 --mode 2560x1440_40.00 --verbose

elif [ $1 == "-e" ] || [ $1 == "--stop" ]; then
	echo "Stopping one..."
	one stop
	echo "Stopping sunstone-server..."
	sunstone-server stop

elif [ $1 == "-h" ] || [ $1 == "--help" ]; then
	echo "Usage: ./start.sh [OPTION]"
	echo "Start and stop one and sunstone-server."
	echo ""
	echo "Mandatory arguments"
	echo "   -s, --start                                Start"
	echo "   -e, --stop                                 Stop"
	echo "   -h, --help                                 Help"

else
	echo "Unknown option $1"
	echo "Try one.sh -h"

fi
