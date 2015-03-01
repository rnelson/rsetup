#!/usr/local/bin/bash
DIR="/var/db/rsetup"

if [ ! -d $DIR ]; then
	sudo mkdir $DIR
	sudo chown `id -u`:`id -g` $DIR
fi

CURRENTWEEK=`date +%V`
if [ $CURRENTWEEK -eq 01 ]; then
	echo -1 > $DIR/lastportsupdate
fi

LASTUPDATE=-1
if [ -f $DIR/lastportsupdate ]; then
	LASTUPDATE=`cat $DIR/lastportsupdate`
fi

if [ $LASTUPDATE -lt $CURRENTWEEK ]; then
	echo "Updating ports tree..."
	sudo portsnap fetch >/dev/null
	if [ -d /usr/ports ]; then
		sudo portsnap update >/dev/null
	else
		sudo portsnap extract >/dev/null
	fi
	echo $CURRENTWEEK > $DIR/lastportsupdate
	echo "Ports tree updated."
	echo ""
fi