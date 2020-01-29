#!/bin/bash
# ***************************************************************************
# Automatisches Indexieren neuer Webschnitte in PyWB
# Autor: Kuss, 16.09.2019
#        vervollständigt 16.01.2020
# ***************************************************************************
archive_lesesaal=/opt/pywb/collections/lesesaal/archive
archive_weltweit=/opt/pywb/collections/weltweit/archive
logfile=/opt/pywb/logs/ks.auto_add.log
data_basedir=/data2
echo "" >> $logfile
echo "********************************************************************************" >> $logfile
echo `date`
echo `date` >> $logfile
echo "START Auto adding new web harvests"
echo "START Auto adding new web harvests" >> $logfile
echo "********************************************************************************" >> $logfile

# bash-Funktionen
function update_collection {
  # Aktualisiert alle neu hinzugekommenen oder kürzlich geänderten Webarchivdateien eines Verzeichnisses (z.B. wpull-data/) in einem pywb-Archiv (u.a. pywb-Index)
  local dataverz=$1;
  local suchmuster=$2;
  local archivename=$3
  local archive=$4;
  # Schleife über alle im Datenverzeichnis angelegten WARC-Dateien
  cd $dataverz
  for warcfile in $suchmuster ; do
    # echo "warcfile=$dataverz/$warcfile" >> $logfile
    warcbase=`basename $warcfile`
    # Gibt es schon einen gleichnamigen symbolischen Link im Archiv ?
    if [ -f $archive/$warcbase ]; then
      # echo "Archivfile existiert" >> $logfile
      # Ist das Archivfile neuer ?
      if test `find $archive/$warcbase -prune -newer $dataverz/$warcfile`; then
        # echo "Archivfile ist neuer. Nichts zu tun." >> $logfile
        continue
      fi
      echo "Archivfile ist älter" >> $logfile
      # Archivfile (symbolischer Link) löschen
      rm $archive/$warcbase
    fi
    # Archivfile exsitiert noch nicht oder ist älter
    echo "warcfile=$dataverz/$warcfile" >> $logfile
    echo "Warcfile wird hinzugefügt." >> $logfile
    /opt/pywb/bin/ks.add_warc.sh $archivename $dataverz/$warcfile >> $logfile
  done
}

# 1. wpull-data
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
echo "START auto-indexing new wpull harvests" >> $logfile
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
update_collection $data_basedir/wpull-data "edoweb:*/20*/*.warc.gz" lesesaal $archive_lesesaal

# 2. heritrix-data
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
echo "START auto-indexing new heritrix harvests" >> $logfile
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
update_collection $data_basedir/heritrix-data "edoweb:*/20*/warcs/*.warc.gz" lesesaal $archive_lesesaal

# 3. cdn-data
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
echo "START auto-indexing new cdn harvests in restricted access collection" >> $logfile
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
update_collection $data_basedir/cdn-data "edoweb_cdn:*/20*/*.warc.gz" lesesaal $archive_lesesaal
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
echo "START auto-indexing new cdn harvests in public collection" >> $logfile
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
# update_collection $data_basedir/cdn-data "edoweb_cdn:*/20*/*.warc.gz" weltweit $archive_weltweit

# 4. public-data
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
echo "START auto-indexing new public harvests (soft links)" >> $logfile
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++" >> $logfile
# update_collection $data_basedir/public-data "edoweb:*/20*/*.warc.gz edoweb:*/20*/warcs/*.warc.gz" weltweit $archive_weltweit

echo "********************************************************************************" >> $logfile
echo `date`
echo `date` >> $logfile
echo "ENDE Auto adding new web harvests"
echo "ENDE Auto adding new web harvests" >> $logfile
echo "********************************************************************************" >> $logfile
exit 0
