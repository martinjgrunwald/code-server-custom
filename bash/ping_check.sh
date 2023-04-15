#!/bin/bash

HOST="<asdkdjfhgdaskjgsdkjfg.com"

if ping -c 1 $HOST >/dev/null; then
    if [ $(ping -c 1 $HOST | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }') -eq 1 ]; then
        #Filme
        rsync -av /mnt/transfer/Public/Flori/Filme/ /mnt/plex-flori/Filme --log-file=/var/log/plex-flori.log --ignore-existing
        mv /mnt/transfer/Public/Flori/Filme/* '/mnt/transfer/Public/Flori/!geladen/'

        #Serien sync
        input="/mnt/transfer/Public/Flori/serien.txt"
        /usr/bin/dos2unix "$input"
        while IFS= read -r line; do
            echo "$line"
            rsync -av /mnt/plexmedia/Serien/"$line" /mnt/plex-flori/Serien --log-file=/var/log/plex-flori.log --ignore-existing
            rsync -av /mnt/plexplus/Serien/"$line" /mnt/plex-flori/Serien --log-file=/var/log/plex-flori.log --ignore-existing
        done <"$input"
        #Serien transfer
        rsync -av /mnt/transfer/Public/Flori/Serien/ /mnt/plex-flori/Serien --log-file=/var/log/plex-flori.log --ignore-existing
        mv /mnt/transfer/Public/Flori/Serien/* '/mnt/transfer/Public/Flori/!geladen/'
    else
        echo "$HOST is unreachable (packet loss)"
    fi
else
    echo "$HOST is unreachable"
fi
