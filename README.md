# Bootable OSX USB

	Version 1.1

This is a super simple script that I created to make creating a bootable OSX usb very quick and painless.
The script leverges the tool that is found inside the OSX installer and has a couple of helpful bits and pieces to enable any OSX user create a bootable USB for backup or a debugging tool.

### Usage

	sudo sh osxUSB.sh 

This is an automated workflow, that will look for a usb called OSX and prepare it for use, then load OSX onto it.

	sudo sh osxUSB.sh /path/to/USB

This worksflow prompts the user for some minor input so that you can be sure you have entered the right path, and not wipe the wrong drive by accident.

### Flags

	-h displays the help file
	-e displays a list of errors that can be generated, their descriptions and potential fixes


For and questions or queries, message me on twitter: @edlittles 


### Versions
 - Version 1.1 - Support for El Capitan and additional help descriptions
 - Version 1.0 - initial release


*Software is provided under the GNU v3 License.*