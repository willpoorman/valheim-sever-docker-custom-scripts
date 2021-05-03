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

ZDOID_AND_REST_OF_LINE=${LOG_LINE/*owner /}
ZDOID=${ZDOID_AND_REST_OF_LINE/ disconnected*/i}
echo "ZDOID: $ZDOID"


# Sleep a few random MS to make sure one instance of the user's
# disconnect event gets the lock over the others
USER_DISCONNECT_EVENT_LOCKFILE=$DB_DIR/user_disconnect_event_$ZDOID.lock
let "RANDOM_WAIT_TIME_MS=$RANDOM % 100"
RANDOM_WAIT_TIME_S=`echo "scale=2; $RANDOM_WAIT_TIME_MS/100" | bc`
sleep $RANDOM_WAIT_TIME_S

if [ -f "$USER_DISCONNECT_EVENT_LOCKFILE" ]
then
        echo "USER_DISCONNECT_EVENT_LOCKFILE already set for this ZDOID, exiting"
        exit 4
fi

touch $USER_DISCONNECT_EVENT_LOCKFILE

echo "Checking user zdoid mapping file for username"

USERNAME_AND_ZDOID=`grep "$ZDOID" $DB_DIR/$USER_AND_ZDOID_TMP_DB`
echo "USERNAME_AND_ID: $USERNAME_AND_ZDOID"

if [ -z "$USERNAME_AND_ZDOID" ]
then
        echo "USERNAME_AND_ZDOID not found in zdoid mapping file, exiting"
        exit 5
fi

echo "Deleting entry from zdoid mapping file"
sed -i "/^$USERNAME_AND_ZDOID\$/d" $DB_DIR/$USER_AND_ZDOID_TMP_DB

USERNAME=${USERNAME_AND_ZDOID// :*/};
echo "USERNAME: $USERNAME"

MESSAGE="$USERNAME disconnected"

$SCRIPTS_DIR/send_discord_message.sh "$MESSAGE"

rm $USER_DISCONNECT_EVENT_LOCKFILE
