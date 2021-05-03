#!/bin/sh

if [ -z "$SCRIPTS_DIR" ]
then
        echo "No SCRIPTS_DIR set"
        exit 1
fi

MESSAGE="Starting server"

$SCRIPTS_DIR/send_discord_message.sh "$MESSAGE"
