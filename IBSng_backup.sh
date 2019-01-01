

service IBSng stop

#remove IBSng cache and log 
usr/bin/psql -d IBSng -U ibs -c "Truncate Table connection_log_details,internet_bw_snapshot,connection_log,internet_onlines_snapshot
service IBSng start

#Remove Log files
rm /var/log/IBSng/ibs_*

su postgres -c "pg_dump IBSng" >   IBSng_"`date +%Y-%m-%d_%H-00`".sql

zip -r -9 IBSng_"`date +%Y-%m-%d_%H-00`".zip  IBSng_"`date +%Y-%m-%d_%H-00`".sql

rm IBSng_"`date +%Y-%m-%d_%H-00`".sql

mv IBSng_"`date +%Y-%m-%d_%H-00`".zip /backup/
