#!/bin/sh

if [ -z "$SCRIPTS_DIR" ]
then
        echo "No SCRIPT_DIR set"
        exit 1
fi

MESSAGE="Server is up and running"

$SCRIPTS_DIR/send_discord_message.sh "$MESSAGE"
