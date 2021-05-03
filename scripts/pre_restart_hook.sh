#!/bin/sh

if [ -z "$SCRIPTS_DIR" ]
then
	echo "No SCRIPTS_DIR set"
	exit 1
fi

MESSAGE="Restarting server in one minute!"
$SCRIPTS_DIR/send_discord_message.sh "$MESSAGE"

sleep 60

MESSAGE="Server is restarting now!"
$SCRIPTS_DIR/send_discord_message.sh "$MESSAGE"
