#!/bin/sh
echo "filmvilag.sh: start"
cp $1/iptvupdate/custom/filmvilag.sh $2/iptvupdate/custom/filmvilag.sh
status=$?
if [ $status -ne 0 ]; then
	echo "filmpapa.sh: Critical error. The $0 file can not be copied, error[$status]."
	exit 1
fi
cp $1/hosts/hostfilmvilag.py $2/hosts/
hosterr=$?
cp $1/icons/logos/filmvilaglogo.png $2/icons/logos/
logoerr=$?
cp $1/icons/PlayerSelector/filmvilag*.png $2/icons/PlayerSelector/
iconerr=$?
if [ $hosterr -ne 0 ] || [ $logoerr -ne 0 ] || [ $iconerr -ne 0 ]; then
	echo "filmvilag.sh: copy error from source hosterr[$hosterr], logoerr[$logoerr, iconerr[$iconerr]"
fi
wget --no-check-certificate https://github.com/e2iplayerhosts/filmvilag/archive/master.zip -q -O /tmp/filmvilag.zip
if [ -s /tmp/filmvilag.zip ] ; then
	unzip -q -o /tmp/filmvilag.zip -d /tmp
	cp -r -f /tmp/filmvilag-master/IPTVPlayer/hosts/hostfilmvilag.py $2/hosts/
	hosterr=$?
	cp -r -f /tmp/filmvilag-master/IPTVPlayer/icons/* $2/icons/
	iconerr=$?
	if [ $hosterr -ne 0 ] || [ $iconerr -ne 0 ]; then
		echo "filmvilag.sh: copy error from filmpapa-master hosterr[$hosterr], iconerr[$iconerr]"
	fi
else
	echo "filmvilag.sh: filmvilag.zip could not be downloaded."
fi
rm -r -f /tmp/filmvilag*
echo "filmvilag.sh: exit 0"
exit 0