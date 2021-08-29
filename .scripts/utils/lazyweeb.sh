#!/usr/bin/env bash

# BUILDING THE URL TO QUERY
BASE_URL='https://nyaa.si/?f=0&c=0_0&q='
QUERY=$(rofi -dmenu -font "Hack 20" -mesg "Search for an anime")
FINAL_URL="${BASE_URL}${QUERY}"

if [ "${QUERY}" != "" ]
then
    # CURL THE HTML
    A_TAGS=$(curl $FINAL_URL | grep "/view")

    # PARSE OUT TORRENT ID AND TITLE
    DOWNLOAD_NUMS=$(cat <<< ${A_TAGS} | awk -F'"' '$0=$2' | grep -o '[0-9][0-9][0-9][0-9][0-9][0-9][0-9]')
    TITLES=$(cat <<< ${A_TAGS} | awk -F'"' '$0=$4' | grep "\[")

    # SPLIT THE STRINGS ON NEW LINE INTO ARRAYS
    IFS=$'\n'
    read -d '' -r -a TITLES_NEW <<<"$TITLES"
    read -d '' -r -a DOWNLOAD_NUMS_NEW <<<"$DOWNLOAD_NUMS"

    # GET CHOICE FROM ROFI
    CHOICE_NAME=$(rofi -dmenu -mesg "Select a torrent" -font "Hack 15" -input <<< ${TITLES})

    #FIND DOWNLOAD NUMBER OF CHOICE, DOWNLOAD IT, AND REMOVE THE TORRENT FILE
    for i in "${!TITLES_NEW[@]}"; do
        if [ "${TITLES_NEW[$i]}" = "$CHOICE_NAME" ]
        then
            wget "https://nyaa.si/download/${DOWNLOAD_NUMS_NEW[$i]}.torrent" -O "/tmp/${DOWNLOAD_NUMS_NEW[$i]}.torrent"
            qbittorrent "/tmp/${DOWNLOAD_NUMS_NEW[$i]}.torrent" &
        fi
    done
fi
