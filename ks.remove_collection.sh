#!/bin/bash
# Entfernt eine Sammlung aus pywb 
# ACHTUNG ! Alle Daten der Sammlung, insbesondere der Index, werden gelöscht !!!
coll=$1
pywb_basedir=/opt/pywb
collections=$pywb_basedir/collections
rm -r $collections/$coll
