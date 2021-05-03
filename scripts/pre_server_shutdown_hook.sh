#!/bin/sh

if [ -z "$SCRIPTS_DIR" ]
then
	echo "No SCRIPT_DIR set"
	exit 1
fi

MESSAGE="Shutting down server in one minute!"
$SCRIPTS_DIR/send_discord_message.sh "$MESSAGE"

sleep 60

MESSAGE="Server is shutting down now!"
$SCRIPTS_DIR/send_discord_message.sh "$MESSAGE"
