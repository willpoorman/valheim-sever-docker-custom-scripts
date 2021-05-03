#!/bin/sh

if [ -z "$DISCORD_WEBHOOK" ]
then
        echo "No DISCORD_WEBHOOK set"
        exit 1
fi

if [ -z "$DISCORD_AVATAR_URL" ]
then
        echo "No DISCORD_AVATAR_URL set"
        exit 2
fi

USERNAME=$DISCORD_USERNAME
if [ -z "$DISCORD_USERNAME" ]
then
        USERNAME="Valheim Server: $SERVER_NAME"
fi

MESSAGE=$1
echo "Notifying Discord channel with message: $MESSAGE"

curl -sfSL -X POST -H "Content-Type: application/json" -d "{\"username\":\"$USERNAME\", \"avatar_url\": \"$DISCORD_AVATAR_URL\", \"content\":\"$MESSAGE\"}" "$DISCORD_WEBHOOK"
