#!/bin/bash
# Fügt eine WARC-Datei zum Index "wget-data" einer Sammlung hinzu.
# Fügt sie also zum Index index_wget.cdxj hinzu.
# Beispielaufruf: $0 lesesaal /data2/wget-data/edoweb:1024/20050131/warcs/WEB-www.trimmelter-sv.de-20050131.warc.gz
# +------------------+------------+-----------------------------------------+
# | Autor            | Datum      | Grund                                   |
# +------------------+------------+-----------------------------------------+
# | Ingolf Kuss      | 19.06.2020 | Neuanlage; Bearbeitung für EDOZWO-1014  |
# +------------------+------------+-----------------------------------------+
coll=$1
warcfile=$2
echo "********************************************************************************"
echo `date`
echo "Adding warc file $warcfile to index_wegt.cdxj of collection $coll"
echo "********************************************************************************"

pywb_basedir=/opt/pywb
collections=$pywb_basedir/collections
collection=$collections/$coll
warcbase=`basename $warcfile`
actdir=$PWD

# Aktuellen Index index.cdxj temporär umbenennen
cd $collection/indexes
index_cdxj_bak=""
datetimestamp=""
if [ -f index.cdxj ]; then
  datetimestamp=`date +'%Y%m%d%H%M%S%3N'`
  index_cdxj_bak=index.$datetimestamp.cdxj
  mv index.cdxj $index_cdxj_bak
fi
if [ -n "$index_cdxj_bak" ]; then
  echo "index.cdxj gab es schon; temporär umbenannt nach $index_cdxj_bak"
fi

# Sicherungskopie von Index index_wget.cdxj machen
index_wget_cdxj_bak=""
datetimestamp=""
if [ -f index_wget.cdxj ]; then
  datetimestamp=`date +'%Y%m%d%H%M%S%3N'`
  index_wget_cdxj_bak=index_wget.cdxj.$datetimestamp
  cp -p index_wget.cdxj $index_wget_cdxj_bak
fi
if [ -n "$index_wget_cdxj_bak" ]; then
  echo "index_wget.cdxj gab es schon; Sicherungskopie $index_wget_cdxj_bak angelegt."
fi

# Umbenennen von index_wget.cdxj nach index.cdxj
if [ -f index_wget.cdxj ]; then
  mv index_wget.cdxj index.cdxj
fi

# WARC-Datei zu index.cdxj hinzufügen
/opt/pywb/bin/ks.index_warc.sh $coll $warcfile

# Umbenennung von index.cdxj nach index_wget.cdxj
cd $collection/indexes
if [ -f index.cdxj ]; then
  mv index.cdxj index_wget.cdxj
fi
echo "neu aufgebauten Index umbenannt nach index_wget.cdxj"

# Zurückholen des temporär umbenannten Index index.cdxj
if [ -n "$index_cdxj_bak" ]; then
  mv $index_cdxj_bak index.cdxj
  echo "schon vorhandenen und gesicherten Index $index_cdxj_bak wieder zurück benannt nach index.cdxj"
fi
cd $actdir
echo "********************************************************************************"
echo `date`
echo "ENDE Adding warc file $warcfile to index_wegt.cdxj of collection $coll"
echo "********************************************************************************"

exit 0
