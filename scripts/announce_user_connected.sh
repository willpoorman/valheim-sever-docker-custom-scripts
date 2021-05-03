#!/bin/bash

if [ -z "$SCRIPTS_DIR" ]
then
        echo "No SCRIPT_DIR set"
        exit 1
fi

if [ -z "$DB_DIR" ]
then
        echo "No DB_DIR set"
        exit 2
fi

if [ -z "$USER_AND_ZDOID_TMP_DB" ]
then
        echo "No USER_AND_ZDOID_TMP_DB set"
        exit 3
fi

read LOG_LINE
echo "Reacting to LOG_LINE: $LOG_LINE"


USERNAME_AND_ZDOID=${LOG_LINE//*ZDOID from /}
echo "USERNAME_AND_ZDOID: $USERNAME_AND_ZDOID"
echo "Storing in tmp user mapping file"
echo "$USERNAME_AND_ZDOID" >> $DB_DIR/$USER_AND_ZDOID_TMP_DB

USERNAME=${USERNAME_AND_ZDOID// :*/};
echo "USERNAME: $USERNAME"

MESSAGE="$USERNAME connected"

$SCRIPTS_DIR/send_discord_message.sh "$MESSAGE"
