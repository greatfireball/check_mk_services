#!/bin/bash

NUMOFUPDATES=$(/usr/lib/update-notifier/apt-check 2>&1)

TOTALUPDATES=${NUMOFUPDATES%;*}
SECURITYUPDATES=${NUMOFUPDATES#*;}

if [ $TOTALUPDATES -lt 10 ] ; then
  status=0
  statustxt=OK
elif [ $TOTALUPDATES -lt 20 ] ; then
  status=1
  statustxt=WARNING
else
  status=2
  statustxt=CRITICAL
fi


echo "$status apt_updates_available count=$TOTALUPDATES;10;20;0; $statustxt - $TOTALUPDATES updates available"

if [ $SECURITYUPDATES -lt 1 ] ; then
  status=0
  statustxt=OK
elif [ $SECURITYUPDATES -lt 5 ] ; then
  status=1
  statustxt=WARNING
else
  status=2
  statustxt=CRITICAL
fi

echo "$status apt_security_updates_available count=$SECURITYUPDATES;1;5;0; $statustxt - $SECURITYUPDATES security updates available"
