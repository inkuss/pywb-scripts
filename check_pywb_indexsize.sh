#!/bin/bash
#
# Monitoring der pywb Indexe
#
# Die Indexe der pywb sollen nicht größer als 10GB werden. Dieses Skipt wird von monit aufgerufen 
# und schickt eine Mail, sobald der Indexe die kritische Größe erreicht.
# Das Skript erwartet die Angabe der maximalen Größe in MB.
#
# Aufruf:
# $ check_pywb_indexsize.sh <pywb-index> <maximale Größe>
# Aufruf in monit Konfiguration mit absoluten Pfaden
# $ /opt/pywb/bin/check_pywb_indexsize.sh /opt/pywb/collections/weltweit/indexes/index.cdxj 10000


while getopts i:m:l: option; do
    case "${option}" in
        i) INDEX=${OPTARG};;
        m) MAXSIZE=${OPTARG};;
        l) LOG=${OPTARG};;
    esac
done


LOGDIR="/opt/pywb/logs"
logfile=$LOGDIR/$LOG

echo $logfile

size=$(du -m "$INDEX" | cut -f 1)
time=`date +%F\ %T`
echo $time, $size >> $logfile

if [ $size -ge $MAXSIZE ]; then
    echo "$INDEX: $size > $MAXSIZE MB"
    exit 1
else
    echo "$INDEX: $size < $MAXSIZE MB"
    exit 0
fi
