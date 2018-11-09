#!/bin/sh

IFS=$'\n'
FILE_LOG='/var/tmp/freedns/freedns_pages.log'
FILE_TOKENS='/var/tmp/freedns/freedns_tokens'
FILE_IP='/var/tmp/freedns/ip'

IP=`curl -s -k https://ipinfo.io/ip`
if [ ! -e "$FILE_IP" ]; then
	OLD_IP="undefined"
else
	OLD_IP=`cat $FILE_IP`
fi

if [ "$IP" != "$OLD_IP" ]; then
	echo $IP > $FILE_IP

	for tokens in `cat $FILE_TOKENS`
	do 
		tokens=`echo $tokens | tr -d '[[:space:]]' | sed -e 's/#.*//g'`
		if [ ! -z $tokens ]; then
			curl -s -k https://freedns.afraid.org/dynamic/update.php?$tokens >> $FILE_LOG 2>&1
		fi
	done
fi