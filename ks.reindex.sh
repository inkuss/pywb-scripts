#!/bin/bash
# Führt eine Re-Indexierung einer Sammlung durch
# Dazu wird wb-manager reindex benutzt.
# Quelle: https://github.com/webrecorder/pywb/wiki/Auto-Configuration-and-Web-Archive-Collections-Manager
# Beispielaufruf: ./ks.reindex.sh test_index
coll=$1
echo "********************************************************************************"
echo `date`
echo "START Re-indexing collection $coll"
echo "********************************************************************************"
pywb_basedir=/opt/pywb
actdir=$PWD
cd $pywb_basedir
/opt/pywb/Python3/bin/wb-manager reindex $coll
cd $actdir
echo "********************************************************************************"
echo `date`
echo "ENDE Re-indexing collection $coll"
echo "********************************************************************************"
exit 0
