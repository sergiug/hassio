#!/bin/bash

#checking and loading .env file
ENV_FILE=.env
[ ! -f $ENV ] && { echo "${ENV_FILE} env file not found."; exit 1;}
source $ENV_FILE

#checking usb mount
ROOT_USB=$USB_ROOT_PATH
[ ! -d $ROOT_USB ] && { echo "usb mount ${ROOT_USB} not found."; exit 1; }

#checking and creating each usb folder and symlink
IFS=:
USB_FOLDERS_LIST=($USB_FOLDERS)
for key in "${!USB_FOLDERS_LIST[@]}"; do
	LINK="${USB_FOLDERS_LIST[$key]}";
	USB_FOLDER=$ROOT_USB/$LINK/

	if [ ! -d $USB_FOLDER ]; then
        	echo "${USB_FOLDER} folder missing. Attempting to create."
        	mkdir $USB_FOLDER
	fi
	if [ ! -L $LINK ]; then
        	echo "${LINK} symlink missing. Attempting to create."
        	ln -s $USB_FOLDER $LINK
	fi
done

echo "Running docker-compose up"
docker-compose up -d
