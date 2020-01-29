# pywb-scripts
scripts for managing content in pywb

# Erstmaliges Hinzufügen von Webinhalten zu Python-Wayback Index & Archiv
# Gesamtindexierung des vorhandenen Bestandes
Autor: I. Kuss  
Erstanlagedatum: 29.Januar 2020  

# I. Lesesaal-Sammlung
Neuaufbau der pywb-Sammlung "lesesaal"  
ssh wayback@wayback  
Löschen der Sammlung "Lesesaal"  
cd /opt/pywb/bin/  
./ks.remove_collection.sh lesesaal  
Neuanlage der Sammlung "Lesesaal"  
cd /opt/pywb  
/opt/pywb/Python3/bin/wb-manager init lesesaal  

Aufteilung auf multiple Indizes:  
In Sammlung "lesesaal"  
1. Index   index.cdxj       wpull-data, cdn-data     Index ca. 3.9 GB groß  
   ./ks.index_wpull-data.sh lesesaal  >> /opt/pywb/logs/ks.index_wpull-data.log  
   In 12h 45m fertig geworden. 690 Archivdateien indexiert (OK).  Index ist 3.95 GB groß  
2. Index   index_htrx.cdxj  heritrix-data            Index ca. 11 GB groß  
   ./ks.index_heritrix-data.sh lesesaal  >> /opt/pywb/logs/ks.index_heritrix-data.log  
   4420 Archivdateien indexiert in 115 Stunden. Index ist 11,03 GB groß.  
3. Index   index_wget.cdxj  wget-data                Index ca. 3.1 GB groß  
   ./ks.index_wget-data.sh lesesaal  >> /opt/pywb/logs/ks.index_wget-data.log  
   Fertig in 12 Std. 1467 Dateien indexiert. Index ist 3.1 GB groß.  


# II. Weltweit-Sammlung
Neuaufbau der pywb-Sammlung "Weltweit"  
ssh wayback@wayback2  
Löschen der Sammlung "Weltweit"  
cd /opt/pywb/bin/  
./ks.remove_collection.sh weltweit  
Neuanlage der Sammlung "Weltweit"  
cd /opt/pywb  
/opt/pywb/Python3/bin/wb-manager init weltweit  
Ein Index  index.cdxj       public-data, cdn-data    Index wird ca. 7? GB groß  
    ACHTUNG !! Die Verzeichnisse  
    /opt/regal/wpull-data, /opt/regal/heritrix-data und /opt/regal/wget-data  
    müssen auf dem wayback-Server eingerichtet sein, jeweils als symbolische Verknüpfungen zu  
    /data2/wpull-data,     /data2/heritrix-data     bzw. /data2/wget-data  .  
   ./ks.index_public-data.sh weltweit  >> /opt/pywb/logs/ks.index_public-data.log  
   Es sind 2479 Archivdateien in public-data/ zu indexieren und 142 Archive in cdn-data/ .  
   29.01.: läuft noch. Bereits 3,8 GB indexiert. 1231 Archivdateien indexiert.  

