#!/usr/local/bin/bash
DIR="/var/db/rsetup"

if [ ! -d $DIR ]; then
	sudo mkdir $DIR
	sudo chown `id -u`:`id -g` $DIR
fi

CURRENTWEEK=`date +%V`
if [ $CURRENTWEEK -eq 01 ]; then
	echo -1 > $DIR/lastupdate
fi

LASTUPDATE=-1
if [ -f $DIR/lastupdate ]; then
	LASTUPDATE=`cat $DIR/lastupdate`
fi

if [ $LASTUPDATE -lt $CURRENTWEEK ]; then
	echo "Updating installed packages..."
	sudo pkg update >/dev/null
	sudo pkg upgrade -y >/dev/null
	echo $CURRENTWEEK > $DIR/lastupdate
	echo "Packages updated."
	echo ""
fi