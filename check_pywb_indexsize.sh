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

index=$1
limit=$2

size=$(du -m "$index" | cut -f 1)

if [ $size -ge $limit ]; then
    echo "$index: $size > $limit MB"
    exit 1
else
    echo "$index: $size < $limit MB"
    exit 0
fi
