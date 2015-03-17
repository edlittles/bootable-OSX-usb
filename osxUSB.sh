#!/bin/bash
#
# osxUSB v1.0
# Creates a bootable OSX installer for use with OSX 10.10 Yosemite
# Copyright (C) 2015  Ed Little
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.





# Create bootable USB for OSX
# Uses `createinstallmedia` in the installer for OSX to create a bootable USB device.
#
# Automate the process by renaming your usb "OSX" and do not pass in the path/to/file parameter


# DO NOT CHANGE
VERSION="1.0"
FILENAME="osxUSB"

# Verbose console output / Debugging set to off (0) by default, enable with (1)
VERBOSE=0


# =========================================================================== #
#                              Script below                                   #
# =========================================================================== #












































if [[ ! -d /var/log/cubbei_script_log ]]; then
	mkdir /var/log/cubbei_script_log
fi

output() {
	if [[ $VERBOSE == 1 ]]; then
		printf "\033[0;32m"
		printf "db: $1"
		echo "\033[0m"
	fi
	echo "$(date +'%d %b %T') $FILENAME: $1" >> /var/log/cubbei_script_log/$FILENAME.log
}

error() {
	printf "\033[31m"
	printf "error found, exiting with error code: "
	printf "\033[0m"
	echo $1
	if [ $# -eq 2 ]; then
		echo "$(date +'%d %b %T') $FILENAME: [error: $1] $2" >> /var/log/cubbei_script_log/$FILENAME.log
	fi
	exit
}

if [[ $1 == "-h" ]]; then
	echo "Usage:"
	echo "sudo sh $FILENAME \n - will look for a usb named OSX and run an automated creation process";
	echo "sudo sh $FILENAME /path/to/usb \n - will wipe the target usb and use it to create a bootable device. \n   Some input from the user will be required.";
	exit
fi

if [[ $(whoami) != root ]]; then
	echo "run as root"
	echo "sudo sh $0 path/to/usb"
	error 2 
fi

echo "\033[0;33mOSX Bootable USB creator -- Version: $VERSION [March 2015]\033[0m"
output "Bootable USB -- Version: $VERSION"

if [[ ! -d /Applications/Install\ OS\ X\ Yosemite.app ]]; then
	echo "OSX installer not found. Please download from the AppStore before continuing."
	echo "NOTE: $0 expects app to be in default applications folder."
	error 3 "OSX Installer not found"
else
	output "Found Installer at path: /Applications"
fi



if [ $# -eq 0 ]; then
	if [[ -d /Volumes/OSX ]]; then
		output "Found default drive: /Volumes/OSX. Starting drive creation"
		sudo /Applications/Install\ OS\ X\ Yosemite.app/Contents/Resources/createinstallmedia --volume /Volumes/OSX --applicationpath /Applications/Install\ OS\ X\ Yosemite.app --nointeraction | tee -a /var/log/cubbei_script_log/$FILENAME.log
	else
		error 4 "Default path to USB not found, please provide path to USB"
	fi
else
	if [[ ! -d $1 ]]; then
		echo "Cannot find supplied path to usb"
		error 4 "Cannot find supplied path to USB: $1"
	else
		output "Starting drive creation"
		sudo /Applications/Install\ OS\ X\ Yosemite.app/Contents/Resources/createinstallmedia --volume "$1" --applicationpath /Applications/Install\ OS\ X\ Yosemite.app
	fi
fi
output "all tasks completed"
echo "\033[0;33mOSX Bootable USB creator: Job Completed\033[0m"